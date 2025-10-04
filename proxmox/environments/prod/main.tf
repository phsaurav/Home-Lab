# Talos K8s Cluster
module "talos-k8s-1" {
  source = "../../modules/talos-k8s"

  cluster_id   = 1
  cluster_name = "talos-k8s"
  pool = "Talos-K8s"

  master_count = 1
  worker_count = 2

  network_cidr = var.talos_k8s_cidr
  gateway      = var.gateway

  clone_template = "talos-tp"
  full_clone     = true

}

# Ubuntu K8s Cluster
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

# Lightweight LXC Containers
module "tk_nas" {
  source = "../../modules/lxc"

  vmid        = 300
  target_node = "proxmox"
  hostname    = "tk-nas"
  ostemplate  = "local:vztmpl/debian-12-turnkey-fileserver_18.0-1_amd64.tar.gz"
  password    = var.lxc_pass
  onboot = true
  unprivileged = true


  # Resources
  cores  = 2
  memory = 4096

  # Storage
  rootfs_storage = "local-lvm"
  rootfs_size    = "8G"

  # Network
  network_bridge = "vmbr0"
  network_ip     = var.tk_nas_ip
  network_gw = var.gateway

  features_enabled = true
  features = {
    nesting      = true
  }

  # Startup
  startup = "order=10,up=10"

  # Tags
  tags = "lxc,nas,prod"
}

module "pi_hole" {
  source = "../../modules/lxc"

  vmid         = 311
  target_node  = "proxmox"
  hostname     = "pi-hole"
  ostemplate   = "local:vztmpl/debian-12-standard_12.12-1_amd64.tar.zst"
  password     = var.lxc_pass
  onboot = true
  unprivileged = true

  # Resources
  cores  = 1
  memory = 2048
  swap = 0

  # Storage
  rootfs_storage = "local-lvm"
  rootfs_size    = "8G"

  # Network
  network_bridge = "vmbr0"
  network_ip     = var.pi_hole_ip
  network_gw = var.gateway

  features_enabled = true
  features = {
    nesting      = true
    # keyctl       = true
  }

  startup = "order=5,up=10"

  tags = "lxc,dns,prod"
}

module "n8n" {
  source = "../../modules/lxc"

  vmid        = 383
  target_node = "proxmox"
  hostname    = "n8n"
  ostemplate  = "local:vztmpl/debian-12-standard_12.12-1_amd64.tar.zst"
  password    = var.lxc_pass
  onboot      = false
  unprivileged = true

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
  tags = "lxc,prod"
}