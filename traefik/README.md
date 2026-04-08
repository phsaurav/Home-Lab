# Traefik Reverse Proxy

Single HTTPS entrypoint for the entire homelab. Runs on a dedicated LXC container (VMID 388) with Docker.

## Architecture

```
Client -> Pi-hole DNS (*.phsaurav.net -> <TRAEFIK_IP>) -> Traefik (:443) -> Backend (IP:port)
```

- **TLS**: Let's Encrypt wildcard cert for `*.phsaurav.net` via Cloudflare DNS-01 challenge
- **DNS**: Pi-hole wildcard via dnsmasq (`/etc/dnsmasq.d/02-homelab.conf`)
- **Routing**: File-based dynamic config (`config/services.yaml`)

## Service URLs

| Service | URL |
|---------|-----|
| Proxmox | `https://proxmox.phsaurav.net` |
| Pi-hole | `https://pihole.phsaurav.net` |
| Vault | `https://vault.phsaurav.net` |
| n8n | `https://n8n.phsaurav.net` |
| Homepage | `https://dashboard.phsaurav.net` |
| NAS | `https://nas.phsaurav.net` |
| Traefik | `https://traefik.phsaurav.net` |
| ArgoCD | `https://argocd.phsaurav.net` |
| Grafana | `https://grafana.phsaurav.net` |
| Prometheus | `https://prometheus.phsaurav.net` |
| dwc-app | `https://dwc.phsaurav.net` |
| ArgoCD (dev) | `https://argocd-dev.phsaurav.net` |
| Grafana (dev) | `https://grafana-dev.phsaurav.net` |
| Prometheus (dev) | `https://prometheus-dev.phsaurav.net` |
| Gitea | `https://gitea.phsaurav.net` |
| Harbor | `https://harbor.phsaurav.net` |

Backend IPs are configured in `config/services.yaml` on the LXC only (not committed to git).

### Naming Convention

- **Prod / single-env services**: `<service>.phsaurav.net`
- **Dev duplicates**: `<service>-dev.phsaurav.net`

## File Structure

```
traefik/
  docker-compose.yaml       # Traefik container (ports 80, 443)
  traefik.yaml              # Static config: entrypoints, cert resolver, file provider
  .env.example              # Template for CF_DNS_API_TOKEN
  config/
    services.yaml.example   # Template for dynamic config (actual file lives on LXC only)
```

On the LXC, files live at `/opt/traefik/`. The `.env` (Cloudflare token) and `config/services.yaml` (backend IPs) are on the LXC only and not in git.

## Prerequisites

- Client devices must use Pi-hole as their DNS server
- Cloudflare API token with `Zone:DNS:Edit` permission for `phsaurav.net`

## Common Operations

### Start / Stop / Restart

```bash
# SSH or console into LXC 388
cd /opt/traefik

docker compose up -d        # Start
docker compose down          # Stop
docker compose restart       # Restart
docker compose logs -f       # View logs
```

### Add a New Service

Edit `config/services.yaml` on the LXC -- Traefik watches the file and picks up changes automatically. No restart needed.

Add a router + service block:

```yaml
http:
  routers:
    my-service:
      rule: "Host(`my-service.phsaurav.net`)"
      service: my-service
      entryPoints:
        - websecure

  services:
    my-service:
      loadBalancer:
        servers:
          - url: "http://<backend-ip>:<port>"
```

No Pi-hole or DNS changes needed (the wildcard covers all `*.phsaurav.net`).

### Update Traefik Version

```bash
cd /opt/traefik

# Edit docker-compose.yaml, change image tag (e.g., traefik:v3.5)
# Then:
docker compose pull
docker compose up -d
```

### Force Certificate Renewal

Certificates auto-renew before expiry. To force renewal:

```bash
cd /opt/traefik
docker compose down
docker volume rm traefik_traefik-certs
docker compose up -d
docker compose logs -f  # Watch for new cert issuance
```

### Full Reset (Nuclear Option)

Wipe everything and start fresh:

```bash
cd /opt/traefik
docker compose down -v          # Stop and remove volumes (certs)
docker system prune -af         # Clean all images/cache
docker compose up -d            # Pull fresh image and start
docker compose logs -f
```

### Update Config from Git Repo

After editing template files in the repo:

```bash
# From Proxmox console into LXC 388
cd /opt/traefik
# Copy updated files from repo (via scp, git clone, or paste)
# Traefik auto-reloads config/services.yaml on change

# If traefik.yaml or docker-compose.yaml changed, restart:
docker compose down
docker compose up -d
```

## Pi-hole DNS Config

Wildcard DNS configured in Pi-hole v6 via dnsmasq:

- **File**: `/etc/dnsmasq.d/02-homelab.conf` on Pi-hole LXC
- **Content**: `address=/phsaurav.net/<TRAEFIK_IP>`
- **Requirement**: Pi-hole v6 needs `misc.etc_dnsmasq_d` set to `true` (via `pihole-FTL --config misc.etc_dnsmasq_d true`)

## Terraform

The LXC container is defined in `proxmox/environments/prod/main.tf` as `module "traefik"`:

- VMID: 388
- IP: defined in `prod.tfvars` (variable `traefik_ip`)
- Resources: 1 core, 512MB RAM, 8GB storage
- Features: nesting + keyctl (for Docker)
- AppArmor: `unconfined` (required for Docker in unprivileged LXC, set in `/etc/pve/lxc/388.conf`)
- Startup order: 4 (boots before Pi-hole and all other services)

## Troubleshooting

**Traefik won't start (proc mount error)**:
On Proxmox host: add `lxc.apparmor.profile: unconfined` to `/etc/pve/lxc/388.conf` and reboot the LXC.

**DNS not resolving**:
Verify Pi-hole: `nslookup grafana.phsaurav.net <PIHOLE_IP>`
If NXDOMAIN: check `/etc/dnsmasq.d/02-homelab.conf` exists and `misc.etc_dnsmasq_d` is `true`

**Self-signed cert instead of Let's Encrypt**:
Check Cloudflare token: `docker exec traefik printenv CF_DNS_API_TOKEN`
Check logs: `docker compose logs | grep -i acme`
Force renewal: remove cert volume and restart (see above)

**404 on a service**:
Verify the `Host()` rule in `config/services.yaml` matches the URL you're accessing.
Check backend is reachable: `docker exec traefik wget -qO- http://<backend-ip>:<port>`
