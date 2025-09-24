output "container_id" {
  description = "The ID of the created LXC container"
  value       = proxmox_lxc.lxc_container.vmid
}

output "container_name" {
  description = "The hostname/name of the created LXC container"
  value       = proxmox_lxc.lxc_container.hostname
}

output "container_ip" {
  description = "The IP address of the LXC container"
  value       = var.network_ip
}

output "container_node" {
  description = "The Proxmox node the container is deployed on"
  value       = proxmox_lxc.lxc_container.target_node
}

output "container_pool" {
  description = "The resource pool the container belongs to"
  value       = proxmox_lxc.lxc_container.pool
}

output "container_ostemplate" {
  description = "The OS template used for the container"
  value       = proxmox_lxc.lxc_container.ostemplate
}

output "container_rootfs_size" {
  description = "The root filesystem size"
  value       = var.rootfs_size
}

output "container_rootfs_storage" {
  description = "The storage location of the container's root filesystem"
  value       = var.rootfs_storage
}