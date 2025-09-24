# ubuntu-1 VM Outputs
 output "ub_1_vm_details" {
   value = {
     id   = module.ubuntu_vm_1.vm_id
     name = module.ubuntu_vm_1.vm_name
     mac  = module.ubuntu_vm_1.vm_mac
     ip   = module.ubuntu_vm_1.vm_ip_config
   }
 }

# ubuntu-2 VM Outputs
 output "ub_2_vm_details" {
   value = {
     id   = module.ubuntu_vm_2.vm_id
     name = module.ubuntu_vm_2.vm_name
     mac  = module.ubuntu_vm_2.vm_mac
     ip   = module.ubuntu_vm_2.vm_ip_config
   }
 }