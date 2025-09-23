output "vm_id" {
  description = "The unique VM ID assigned to the Talos VM"
  value       = proxmox_vm_qemu.talos-vm.vmid
}

output "vm_name" {
  description = "The name of the Talos VM"
  value       = proxmox_vm_qemu.talos-vm.name
}

output "mac_address" {
  description = "The MAC address of the primary network interface"
  value       = proxmox_vm_qemu.talos-vm.network[0].macaddr
}

output "ip_address" {
  description = "The IP address of the primary network interface"
  value       = proxmox_vm_qemu.talos-vm.default_ipv4_address
}
