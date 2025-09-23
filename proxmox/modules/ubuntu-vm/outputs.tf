output "vm_id" {
  description = "The ID of the created VM"
  value       = proxmox_vm_qemu.ubuntu_vm.vmid
}

output "vm_name" {
  description = "The name of the created VM"
  value       = proxmox_vm_qemu.ubuntu_vm.name
}

output "vm_node" {
  description = "The Proxmox node the VM is deployed on"
  value       = proxmox_vm_qemu.ubuntu_vm.target_node
}

output "vm_pool" {
  description = "The resource pool the VM belongs to"
  value       = proxmox_vm_qemu.ubuntu_vm.pool
}

output "vm_memory" {
  description = "The memory allocation of the VM in MB"
  value       = proxmox_vm_qemu.ubuntu_vm.memory
}

output "vm_cores" {
  description = "The number of CPU cores assigned to the VM"
  value       = proxmox_vm_qemu.ubuntu_vm.cpu[0].cores
}


output "vm_tags" {
  description = "The tags assigned to the VM"
  value       = proxmox_vm_qemu.ubuntu_vm.tags
}

output "vm_clone_template" {
  description = "The template used to clone the VM"
  value       = proxmox_vm_qemu.ubuntu_vm.clone
}

output "vm_ip_config" {
  description = "The IP configuration of the VM"
  value       = proxmox_vm_qemu.ubuntu_vm.ipconfig0
}

output "vm_ssh_user" {
  description = "The SSH user for the VM"
  value       = proxmox_vm_qemu.ubuntu_vm.ciuser
}

output "vm_network_bridge" {
  description = "The network bridge used by the VM"
  value       = proxmox_vm_qemu.ubuntu_vm.network[0].bridge
}

output "vm_disk_size" {
  description = "The disk size of the VM"
  value       = var.disk_size
}

output "vm_disk_storage" {
  description = "The storage location of the VM disk"
  value       = var.disk_storage
}

output "vm_status" {
  description = "The current status of the VM"
  value       = proxmox_vm_qemu.ubuntu_vm.agent
}

output "vm_mac" {
  description = "The MAC address of the VM's network interface"
  value       = proxmox_vm_qemu.ubuntu_vm.network[0].macaddr
}