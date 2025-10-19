# PH's HomeLab

A bare-metal `Proxmox` infrastructure provisioned using `Terraform` (IaC) and established with a complete GitOps automation pipeline with `ArgoCD` and `Ansible`, hosting a segregated `Dev` environment with an `Ubuntu` cluster for continuous experimentation with Cloud, DevOps, Networking, and Automation. 

Alongside it has a `Production` environment consisting of lightweight `LXC` containers providing essential services, and a lightweight `Talos` Linux Kubernetes cluster for project and service deployment, focusing on high availability and disaster recovery. 

The whole architecture enforces a security-first posture by managing all credentials through HashiCorp Vault, Ansible Vault, and SOPS encryption as necessary.

<img width="5747" height="3763" alt="HomeLab_Arch" src="https://github.com/user-attachments/assets/3573dc79-e3cd-4912-b267-feeca986b837" />

## [Directory Overview](docs/proxmox.md)
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
