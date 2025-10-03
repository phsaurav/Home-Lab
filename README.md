# PH's HomeLab

![img.png](img.png)

## [ProxMox Setup](docs/proxmox.md)
ProxMox is the backbone of the homelab we are using ProxMox for our virtualization setup.
```md
HomeLab/
├── .envrc                           # Dir Env Variables
├── .git/
├── .gitignore
├── .sops.yaml                       # SOPS encryption configuration
├── README.md
├── proxmox/                         # Terraform for Proxmox Infrastructure
│   ├── environments
│   │   ├── dev
│   │   │   ├── backend.tf
│   │   │   ├── backend.tf.enc
│   │   │   ├── dev.tfvars
│   │   │   ├── dev.tfvars.enc
│   │   │   ├── main.tf
│   │   │   ├── outputs.tf
│   │   │   ├── variables.tf
│   │   │   └── versions.tf
│   │   └── prod
│   │       ├── backend.tf
│   │       ├── backend.tf.enc
│   │       ├── main.tf
│   │       ├── outputs.tf
│   │       ├── prod.tfvars
│   │       ├── prod.tfvars.enc
│   │       ├── variables.tf
│   │       └── versions.tf
│   ├── modules
│   │   ├── lxc
│   │   ├── talos-vm
│   │   ├── ubuntu-k8s
│   │   └── ubuntu-vm
│   └── readme.md
├── talos/                            # Talos cluster configs
└── ansible/                          # New: Ansible automation
    ├── ansible.cfg
    ├── requirements.yml
    ├── inventories/
    │   ├── prod/
    │   └── dev/
    ├── playbooks/
    │   ├── site.yml
    │   ├── lxc/
    │   │   ├── deploy-all-lxc.yml
    │   │   ├── deploy-n8n.yml
    │   │   ├── deploy-pihole.yml
    │   │   └── maintenance.yml
    │   ├── kubernetes/
    │   │   ├── cluster-setup.yml
    │   │   ├── cluster-upgrade.yml
    │   │   ├── node-maintenance.yml
    │   │   └── applications/
    │   │       ├── deploy-monitoring.yml
    │   │       ├── deploy-ingress.yml
    │   │       └── deploy-storage.yml
    │   └── common/
    │       ├── security-hardening.yml
    │       ├── backup-setup.yml
    │       └── monitoring-agents.yml
    ├── roles/
    │   ├── common/
    │   │   ├── tasks/main.yml
    │   │   ├── handlers/main.yml
    │   │   ├── vars/main.yml
    │   │   ├── defaults/main.yml
    │   │   └── templates/
    │   ├── lxc/
    │   │   ├── n8n/
    │   │   ├── pihole/
    │   │   ├── nas/
    │   │   └── base/
    │   ├── kubernetes/
    │   │   ├── master/
    │   │   ├── worker/
    │   │   ├── cni/
    │   │   ├── storage/
    │   │   └── monitoring/
    │   └── security/
    │       ├── fail2ban/
    │       ├── ufw/
    │       └── ssh-hardening/
    └── vault/
        ├── production.yml
        ├── development.yml
        └── staging.yml
```