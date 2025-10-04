################################################################################
# General Purpose Dev Ubuntu VM + Jump Host
################################################################################
module "ubuntu_vm_1" {
  source = "../../modules/ubuntu-vm"

  # Basic VM Configuration
  vm_name     = "ubuntu"
  vmid        = 100
  target_node = "proxmox"
  pool        = "VM"
  clone_template = null
  full_clone = false

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
  ip_config      = var.ub_ip_config
  vm_ip          = var.ub_vm_ip

  # Cloud-init Settings
  ci_user     = var.ci_user
  ci_password = var.ci_password
  ssh_private_key_path = var.ssh_private_key_path
  ssh_public_key = var.ssh_public_key

  # Run provisioner on startup
  enable_provisioners = false

  # Tags
  tags = "ubuntu,dev"
}

module "ubuntu_vm_2" {
  source = "../../modules/ubuntu-vm"

  # Basic VM Configuration
  vm_name     = "ubuntu-2"
  vmid        = 101
  target_node = "proxmox"
  pool        = "VM"
  clone_template = "ubuntu-cid-tp"
  full_clone = true

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
  ip_config      = var.ub_2_ip_config
  vm_ip          = var.ub_2_vm_ip

  # Cloud-init Settings
  ci_user     = var.ci_user
  ci_password = var.ci_password
  ssh_private_key_path = var.ssh_private_key_path
  ssh_public_key = var.ssh_public_key

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

  cluster_id    = 2
  cluster_name  = "ubuntu-k8s"
  pool = "Ubuntu-K8s"

  master_count  = 1
  worker_count  = 2

  network_cidr = var.ub_k8s_cidr
  gateway      = var.gateway

  clone_template = "ubuntu-cid-tp"
  ci_user        = var.ci_user
  ci_password    = var.ci_password


  master_memory = 4096
  worker_memory = 4096
}