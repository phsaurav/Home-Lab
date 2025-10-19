# PH's HomeLab

**[Tech Stack](#tech-stack)** • **[Directory Overview](#directory-overview)** • **[Gallery](#gallery)** • **[Road Map](#road-map)** 

A bare-metal `Proxmox` infrastructure provisioned using `Terraform` (IaC) and established with a complete GitOps automation pipeline with `ArgoCD` and `Ansible`, hosting a segregated `Dev` environment with an `Ubuntu` cluster for continuous experimentation with Cloud, DevOps, Networking, and Automation. 

Alongside it has a `Production` environment consisting of lightweight `LXC` containers providing essential services, and a lightweight `Talos` Linux Kubernetes cluster for project and service deployment, focusing on high availability and disaster recovery. 

The whole architecture enforces a security-first posture by managing all credentials through HashiCorp `Vault`, Ansible Vault, and `SOPS` encryption as necessary.

<img width="5747" height="3763" alt="HomeLab_Arch" src="https://github.com/user-attachments/assets/3573dc79-e3cd-4912-b267-feeca986b837" />

## Tech Stack
<table>
    <tr>
        <th>Logo</th>
        <th>Name</th>
        <th>Description</th>
    </tr>
    <tr>
        <td><img width="32" src="https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/proxmox/proxmox-original-wordmark.svg"></td>
        <td><a href="https://www.proxmox.com/en/products/proxmox-virtual-environment/overview">Proxmox VE</a></td>
        <td>The backbone of this homelab is an open-source server virtualization platform. All LXC containers and VMs are running on this environment.</td>
    </tr>
    <tr>
        <td><img width="32" src="https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/terraform/terraform-original.svg"></td>
        <td><a href="https://developer.hashicorp.com/terraform">Terraform</a></td>
        <td>This is the Infrastructure As Code tool that provisions assets inside Proxmox VE and supporting assets in the Cloud. Here, these provisions create two separate environments, Dev and Prod. Read this doc to learn more about the implementation <a href="proxmox/readme.md"> Here </a></td>
    </tr>
    <tr>
        <td><img width="32" src="https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/ubuntu/ubuntu-original.svg"></td>
        <td><a href="https://ubuntu.com/server">Ubuntu Server</a></td>
        <td>Base OS for development VMs.</td>
    </tr>
    <tr>
        <td><img width="32" src="https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/debian/debian-original.svg"></td>
        <td><a href="https://www.debian.org/">Debian</a></td>
        <td>Base OS for LXC Containers.</td>
    </tr>
    <tr>
        <td><img width="32" src="https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/talos/talos-original.svg"></td>
        <td><a href="https://www.talos.dev/">Talos</a></td>
        <td>Talos Linux is a Kubernetes-optimized Linux distro. This is the base OS for the main Kubernetes cluster in the Prod environment. Read this doc to learn more about the implemenation<a href="talos/readme.md"> Here </a></td>
    </tr>
    <tr>
        <td><img width="32" src="https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/ansible/ansible-original.svg"></td>
        <td><a href="https://docs.ansible.com/ansible/latest/index.html">Ansible</a></td>
        <td>Configuration management tool for VMs and Containers. Read this doc to learn more about the implemenation<a href="ansible/readme.md"> Here </a> </td>
    </tr>
    <tr>
        <td><img width="32" src="https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/argocd/argocd-original.svg"></td>
        <td><a href="https://argo-cd.readthedocs.io/en/stable/">ArgoCD</a></td>
        <td>GitOps tool built to deploy applications to Kubernetes. Read this doc to learn more about the implemenation<a href="argocd/readme.md"> Here </a></td>
    </tr>
    <tr>
        <td><img width="32" src="https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/kubernetes/kubernetes-original.svg"></td>
        <td><a href="https://argo-cd.readthedocs.io/en/stable/">Kubernetes</a></td>
        <td>Container-orchestration system, the backbone of dev and prod environment</td>
    </tr>
    <tr>
        <td><img width="32" src="https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/helm/helm-original.svg"></td>
        <td><a href="https://helm.sh/docs/">Helm</a></td>
        <td>Package Manager for Kubernetes</td>
    </tr>
    <tr>
        <td><img width="32" src="https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/docker/docker-original.svg"></td>
        <td><a href="https://argo-cd.readthedocs.io/en/stable/">Docker</a></td>
        <td>Primary Containerization Platform</td>
    </tr>
    <tr>
        <td><img width="32" src="https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/grafana/grafana-original.svg"></td>
        <td><a href="https://grafana.com/grafana/?plcmt=products-nav">Grafana</a></td>
        <td>Kubernetes cluster observation and visualization tool.</td>
    </tr>
    <tr>
        <td><img width="32" src="https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/prometheus/prometheus-original.svg"></td>
        <td><a href="https://prometheus.io/">Prometheus</a></td>
        <td>Kubernetes cluster log aggregation tool.</td>
    </tr>
    <tr>
        <td><img width="32" src="https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/vault/vault-original.svg"></td>
        <td><a href="https://developer.hashicorp.com/vault">Hashicorp Vault</a></td>
        <td>Secret management system for the Homelab. Integrated with ArgoCD via ArgoCD Vault Plugin.</td>
    </tr>
    <tr>
        <td><img width="32" src="https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/nginx/nginx-original.svg"></td>
        <td><a href="https://github.com/kubernetes/ingress-nginx">Nginx</a></td>
        <td>Kubernetes Ingress Controller.</td>
    </tr>
    <tr>
        <td><img width="32" src="https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/raspberrypi/raspberrypi-original.svg"></td>
        <td><a href="https://pi-hole.net/">Pi-hole</a></td>
        <td>Local DNS server for the HomeLab.</td>
    </tr>
    <tr>
        <td><img width="32" src="https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/cloudflare/cloudflare-original.svg"></td>
        <td><a href="https://developers.cloudflare.com/">Cloudflare</a></td>
        <td>DNS Provider and Tunnel.</td>
    </tr>
    <tr>
        <td><img width="32" src="https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/harbor/harbor-original.svg"></td>
        <td><a href="https://developers.cloudflare.com/">Harbor</a></td>
        <td>Self-hosted Image Registry Management Tool</td>
    </tr>
    <tr>
        <td><img width="32" src="https://upload.wikimedia.org/wikipedia/commons/b/bb/Gitea_Logo.svg"></td>
        <td><a href="https://about.gitea.com/">Gitea</a></td>
        <td>Self-hosted Git Repository Hosting</td>
    </tr>
</table>

## Directory Overview
```txt
HomeLab/
├── .envrc                           # Direnv variables automation
├── .gitignore                       # Git ignore patterns
├── .sops.yaml                       # SOPS encryption configuration
├── LICENSE                          # AGPL open source license
├── README.md                        # Repository main documentation
├── ansible/                         # Ansible automation configurations
│   ├── ansible.cfg                  # Ansible common configuration
│   ├── inventories/                 # Inventory configurations
│   │   ├── dev/                     # Development inventory
│   │   └── prod/                    # Production inventory
│   ├── playbooks/                   # Ansible playbooks
│   │   ├── argocd-dev.yaml          # ArgoCD setup for dev server
│   │   ├── cluster_init.yaml        # Control plane initialization
│   │   ├── join_workers.yaml        # Worker nodes joining
│   │   ├── nfs_setup.yaml           # NFS Proxmox setup
│   │   ├── site.yaml                # Initial setup for all hosts
│   │   ├── support_tools.yaml       # Optional support tools
│   │   └── vault_setup.yaml         # Vault production LXC setup
│   ├── roles/                       # Ansible roles
│   │   ├── argocd/                  # ArgoCD role
│   │   ├── base_setup/              # Base setup role
│   │   ├── containerd/              # Containerd role
│   │   ├── control_plane/           # Control plane role
│   │   ├── kube_packages/           # Kubernetes packages role
│   │   ├── nfs_client/              # NFS client role
│   │   ├── node_join/               # Node joining role
│   │   └── support_tools/           # Support tools role
│   ├── secrets.yaml                 # Ansible Vault secrets
│   └── readme.md                    # Ansible documentation
├── argocd/                          # ArgoCD configurations
│   ├── apps/                        # Application manifests
│   │   ├── gitea/                   # Gitea application
│   │   ├── harbor/                  # Harbor application
│   │   ├── monitoring/              # Prometheus + Grafana app
│   │   └── nfs_provisioner/         # NFS storage provisioner
│   ├── base/                        # ArgoCD base project configuration
│   ├── environments/                # Environment-specific configurations
│   │   ├── dev/                     # Development environment
│   │   └── prod/                    # Production environment
│   └── readme.md                    # ArgoCD implementation documentation
├── docs/                            # Detailed feature-specific documentation
├── proxmox/                         # Terraform IaC for Proxmox
│   ├── environments/                # Infrastructure segments
│   │   ├── dev/                     # Development segment
│   │   └── prod/                    # Production segment
│   ├── modules/                     # Terraform modules
│   │   ├── lxc/                     # LXC container module
│   │   ├── talos-k8s/               # Talos dynamic K8s cluster module
│   │   ├── talos-vm/                # Talos VM module
│   │   ├── ubuntu-k8s/              # Ubuntu dynamic K8s cluster module
│   │   └── ubuntu-vm/               # Ubuntu VM module
│   └── readme.md                    # Proxmox Terraform infrastructure documentation
├── scripts/                         # Automation scripts
│   └── check_prometheus.sh          # K8s Prometheus log aggregation check
├── talos/                           # Talos K8s cluster configurations
│   ├── _out/                        # Generated configurations
│   │   ├── decrypt.sh               # Script to decrypt sensitive configurations
│   │   ├── encrypt.sh               # Script to encrypt sensitive configurations
│   │   └── ...                      # Other generated configuration files
│   ├── patches/                     # Patches for control plane and workers
│   ├── secrets.yaml                 # Ansible Vault secrets
│   └── readme.md                    # Talos documentation
└── vault/                           # HashiCorp Vault configurations
    └── secret.yaml.enc              # Vault encrypted configuration
```

## Gallery
|                                                          Proxmox Dashboard                                                           |
|:------------------------------------------------------------------------------------------------------------------------------------:|
|     ![Screenshot 2025-10-19 at 1 29 23 AM-min](https://github.com/user-attachments/assets/757eef7c-5aca-48e0-bd67-6fe207852e6d)      |
|                                                 Grafana Cluster Monitoring Dashboard                                                 |
|     ![Screenshot 2025-10-19 at 1 04 55 AM-min](https://github.com/user-attachments/assets/9442c134-c405-46f4-8601-3b266d26a009)      |
|                                                            GitOps: ArgoCD                                                            |
|     ![Screenshot 2025-10-19 at 1 12 15 AM-min](https://github.com/user-attachments/assets/4e4b8732-cffd-4dff-bbf5-1eccbf849ad8)      |
|                                                  Secret Management: Hashicorp Vault                                                  |
|     ![Screenshot 2025-10-19 at 1 08 26 AM-min](https://github.com/user-attachments/assets/de9ee196-8590-4935-b0fb-9c181d169548)      |
|                                                    Local DNS Management: Pi-hole                                                     |
|     ![Screenshot 2025-10-19 at 1 09 25 AM-min](https://github.com/user-attachments/assets/1fba1e59-8466-45a0-a530-316fdf691ebb)      |
|                                             Gitea Self-hosted Git Repository Management                                              |
|     ![Screenshot 2025-10-19 at 1 22 52 AM-min](https://github.com/user-attachments/assets/5f2374c8-c491-494c-b656-db9daf69a1c5)      |
|                                                 Harbor Self-hosted Image Repository                                                  |
|     ![Screenshot 2025-10-19 at 1 37 42 AM-min](https://github.com/user-attachments/assets/6cdc14be-5e41-40f8-801f-25986a9664ae)      |
|                                                         TurnKey File Server                                                          |
|     ![Screenshot 2025-10-19 at 1 13 30 AM-min](https://github.com/user-attachments/assets/1d98f65d-b51a-4cef-a453-cd4ab3062870)      |
|                                               Gorgeous Bare-Metal Physical Server :-)                                                |
| ![540984190_1901704603707289_7904067712713427409_n](https://github.com/user-attachments/assets/f52af248-9efe-47df-a810-2b5c689f6af4) |

## Road Map

- [x] Setup ProxMox VE on baremetal environment
- [x] Automated bare metal provisioning with Terraform
- [x] Dev & Prod environment provisioning with Terraform
- [x] Modular architecture, easy to add or remove features/components
- [x] Automated Kubernetes Dev Cluster Setup with Ansible
- [x] Automated Kubernetes Prod Cluster Setup with Talos config
- [x] LXC Container Service provisioning with Terraform
- [x] Installing and managing applications using GitOps ArgoCD
- [x] HashiCorp Vault setup for secret managemet
- [x] Pi-hole local DNS server and Turnkey file server setup
- [x] NFS file system setup for kubernetes distributed storage
- [x] Grafana and Prometheus setup for observibility
- [x] Automated backup and restore with rsync
- [x] Gitea and Harbor setup
- [x] NGINX ingress setup
- [ ] ELK Stack Setup in Dev cluster 
- [ ] Automatic rolling upgrade for OS and Kubernetes
- [ ] Automated certificate management for full environment
- [ ] DNS failover to pilot-light AWS infra disaster management setup for Prod cluster
- [ ] Ensuring 99.9% availablity for Prod cluster













