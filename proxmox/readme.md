# Proxmox Terraform Setup

![img.png](img.png)

The infrastructure is devided into development and production environment. The repository follows a standard Terraform module layout:

```txt
proxmox/
├── README.md
├── environments/
│   ├── dev/
│   │   ├── .terraform.lock.hcl
│   │   ├── backend.tf.enc
│   │   ├── dev.tfvars.enc
│   │   ├── dev.tfvars.example
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   ├── variables.tf
│   │   └── versions.tf
│   └── prod/
│       ├── .terraform.lock.hcl
│       ├── backend.tf.enc
│       ├── main.tf
│       ├── outputs.tf
│       ├── prod.tfvars.enc
│       ├── variables.tf
│       └── versions.tf
├── modules/
│   ├── lxc/
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   ├── variables.tf
│   │   └── versions.tf
│   ├── talos-k8s/
│   ├── talos-vm/
│   ├── ubuntu-k8s/
│   └── ubuntu-vm/
└── ...
```

---

## Environment Setup

### Prerequisites & Installation

You’ll need the following tools installed locally:

- `terraform`
- `sops`

On macOS, the easiest path is Homebrew:

```bash
brew install terraform sops 
```

## Working with Encrypted Terraform Files

Sensitive inputs (e.g., `backend.tf`, `*.tfvars`) are stored in SOPS-encrypted form (`*.enc`). Use SOPS to decrypt before running Terraform.

### Decrypting Files

```bash
sops -d proxmox/environments/dev/backend.tf.enc > proxmox/environments/dev/backend.tf
sops -d proxmox/environments/dev/dev.tfvars.enc > proxmox/environments/dev/dev.tfvars
```

### Encrypting Files

After editing a sensitive file, re-encrypt before committing:

```bash
sops -e proxmox/environments/dev/backend.tf > proxmox/environments/dev/backend.tf.enc
sops -e proxmox/environments/dev/dev.tfvars > proxmox/environments/dev/dev.tfvars.enc
```

> Keep decrypted artifacts out of version control. `.gitignore` already covers them—double-check before committing.

---

## Initialising an Environment

```bash
cd proxmox/environments/dev   # swap dev for prod when needed
terraform init
```

If the backend is being bootstrapped for the first time, ensure the remote state bucket or storage is prepared per Confluence guidance.

---

## Routine Terraform Commands

### Development (Dev)

```bash
cd proxmox/environments/dev
terraform plan  -var-file="dev.tfvars"
terraform apply -var-file="dev.tfvars"
```

### Production (Prod)

```bash
cd proxmox/environments/prod
terraform plan  -var-file="prod.tfvars"
terraform apply -var-file="prod.tfvars"
```

> **Do not** run `terraform destroy` against the production environment.
>
> Avoid manual changes to Terraform-managed Proxmox resources; use Terraform for drift-free automation.

---

## Module Overview

- **modules/lxc** – reusable module for lightweight Proxmox containers.
- **modules/ubuntu-vm** – baseline Ubuntu VM provisioning with cloud-init.
- **modules/talos-vm** / **modules/talos-k8s** – Talos OS VM modules for Kubernetes control-plane and worker roles.
- **modules/ubuntu-k8s** – Ubuntu-based Kubernetes nodes via kubeadm.
- Additional modules can be added under `modules/` and referenced from environment `main.tf` files.
