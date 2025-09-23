# ubuntu VM Outputs
output "ub_vm_id" {
  description = "The ID of the created VM"
  value       = module.ubuntu_vm_1.vm_id
}

output "ub_vm_name" {
  description = "The name of the created VM"
  value       = module.ubuntu_vm_1.vm_name
}

output "ub_vm_mac" {
  description = "The MAC address of the VM's network interface"
  value       =  module.ubuntu_vm_1.vm_mac
}

output "ub_vm_ip_config" {
  description = "The IP configuration of the VM"
  value       = module.ubuntu_vm_1.vm_ip_config
}

# ubuntu-2 VM Outputs
output "ub_2_vm_id" {
  description = "The ID of the created VM"
  value       = module.ubuntu_vm_2.vm_id
}

output "ub_2_vm_name" {
  description = "The name of the created VM"
  value       = module.ubuntu_vm_2.vm_name
}

output "ub_2_vm_mac" {
  description = "The MAC address of the VM's network interface"
  value       = module.ubuntu_vm_2.vm_mac
}

output "ub_2_vm_ip_config" {
  description = "The IP configuration of the VM"
  value       = module.ubuntu_vm_2.vm_ip_config
}

