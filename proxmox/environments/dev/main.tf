################################################################################
# General Purpose Dev Ubuntu VM + Jump Host
################################################################################
module "ubuntu_vm_1" {
  source = "../../modules/ubuntu-vm"

  # Basic VM Configuration
  vm_name        = "ubuntu"
  vmid           = 100
  target_node    = "proxmox"
  pool           = "VM"
  clone_template = null
  full_clone     = false

  # Resource Allocation
  memory    = 8192
  cpu_cores = 2

  # Disk Configuration
  disk_size    = "20G"
  disk_storage = "local-lvm"

  # Start automatically
  onboot = false

  # Qemu Agent
  qemu_agent = 1

  # Network Configuration
  network_firewall = true
  ip_config        = var.ub_ip_config
  vm_ip            = var.ub_vm_ip

  # Cloud-init Settings
  ci_user              = var.ci_user
  ci_password          = var.ci_password
  ssh_private_key_path = var.ssh_private_key_path
  ssh_public_key       = var.ssh_public_key

  # Run provisioner on startup
  enable_provisioners = false

  # Tags
  tags = "ubuntu,dev"
}

module "ubuntu_vm_2" {
  source = "../../modules/ubuntu-vm"

  # Basic VM Configuration
  vm_name        = "ubuntu-2"
  vmid           = 101
  target_node    = "proxmox"
  pool           = "VM"
  clone_template = "ubuntu-cid-tp"
  full_clone     = true

  # Resource Allocation
  memory    = 4096
  cpu_cores = 2

  # Disk Configuration
  disk_size    = "10G"
  disk_storage = "local-lvm"

  # Start automatically
  onboot = false

  # Qemu Agent
  qemu_agent = 1

  # Network Configuration
  network_firewall = true
  ip_config        = var.ub_2_ip_config
  vm_ip            = var.ub_2_vm_ip

  # Cloud-init Settings
  ci_user              = var.ci_user
  ci_password          = var.ci_password
  ssh_private_key_path = var.ssh_private_key_path
  ssh_public_key       = var.ssh_public_key

  # Run provisioner on startup
  enable_provisioners = true

  # Tags
  tags = "ubuntu,dev"
}

################################################################################
# Ubuntu K8s Cluster
################################################################################

module "ubunut-k8s-1" {
  source = "../../modules/ubuntu-k8s"

  cluster_id   = 2
  cluster_name = "ubuntu-k8s"
  pool         = "Ubuntu-K8s"

  master_count = 1
  worker_count = 2

  network_cidr = var.ub_k8s_cidr
  gateway      = var.gateway

  clone_template = "ubuntu-k8-base"
  ci_user        = var.ci_user
  ci_password    = var.ci_password


  master_memory = 8192
  worker_memory = 4096
}

################################################################################
# n8n Workflow Automation (migrated from prod)
################################################################################
module "n8n" {
  source = "../../modules/lxc"

  vmid         = 383
  target_node  = "proxmox"
  hostname     = "n8n"
  ostemplate   = "local:vztmpl/debian-12-standard_12.12-1_amd64.tar.zst"
  password     = var.lxc_pass
  onboot       = false
  unprivileged = true
  pool         = "LXC"

  cores  = 2
  memory = 2048
  swap   = 0

  # Storage
  rootfs_storage = "local-lvm"
  rootfs_size    = "10G"

  # Network
  network_bridge = "vmbr0"
  network_ip     = var.n8n_ip
  network_gw     = var.gateway

  features_enabled = true
  features = {
    nesting = true
  }

  # Tags
  tags = "lxc,n8n,dev"
}

################################################################################
# OpenClaw AI Assistant VM
################################################################################
module "openclaw" {
  source = "../../modules/ubuntu-vm"

  # Basic VM Configuration
  vm_name     = "openclaw"
  vmid        = 102
  target_node = "proxmox"
  pool        = "VM"

  clone_template = "ubuntu-cid-tp"
  full_clone     = true

  # Resource Allocation
  memory    = 8192
  cpu_cores = 2

  # Disk Configuration
  disk_size    = "30G"
  disk_storage = "local-lvm"

  # Start automatically
  onboot = true

  # Qemu Agent
  qemu_agent = 1

  # Network Configuration
  network_firewall = true
  ip_config        = format("ip=%s,gw=%s", var.openclaw_ip, var.gateway)
  vm_ip            = split("/", var.openclaw_ip)[0]

  # Cloud-init Settings
  ci_user              = var.ci_user
  ci_password          = var.ci_password
  ssh_private_key_path = var.ssh_private_key_path
  ssh_public_key       = var.ssh_public_key

  # Run provisioner on startup
  enable_provisioners = false

  # Tags
  tags = "ubuntu,openclaw,dev"
}