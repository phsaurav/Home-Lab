 # output "talos_vm_details" {
 #   value = {
 #     id   = module.talos_vm.vm_id
 #     name = module.talos_vm.vm_name
 #     mac  = module.talos_vm.mac_address
 #     ip   = module.talos_vm.ip_address
 #   }
 # }

 output "tk_nas_details"{
   value = {
     id = module.tk_nas.container_id
     name = module.tk_nas.container_name
     ip = module.tk_nas.container_ip
   }
 }

 output "pi_hole_details"{
   value = {
     id = module.pi_hole.container_id
     name = module.pi_hole.container_name
     ip = module.pi_hole.container_ip
   }
 }
