resource "proxmox_lxc" "lxc_container" {
  vmid         = var.vmid
  target_node  = var.target_node
  hostname     = var.hostname
  ostemplate   = var.ostemplate
  password     = var.password
  unprivileged = var.unprivileged
  start        = var.start
  onboot       = var.onboot
  pool         = var.pool

  # Resources
  cores  = var.cores
  memory = var.memory

  # Root filesystem
  rootfs {
    storage = var.rootfs_storage
    size    = var.rootfs_size
  }


  # Dynamic Features
  dynamic "features" {
    for_each = var.features_enabled ? [1] : []
    content {
      fuse       = try(var.features.fuse, null)
      keyctl     = try(var.features.keyctl, null)
      mount      = try(var.features.mount, null)
      nesting    = try(var.features.nesting, null)
      force_rw_sys = try(var.features.force_rw_sys, null)
    }
  }

  # Network configuration
  network {
    name   = var.network_name
    bridge = var.network_bridge
    ip     = var.network_ip
    ip6    = var.network_ip6
  }

  # Startup configuration
  startup = var.startup

  # Tags
  tags = var.tags
}