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

# Ubuntu K8s Cluster Ouputs
output "master_nodes" {
  description = "Details for all master nodes."
  value = module.ubunut-k8s-1.master_nodes
}

output "worker_nodes" {
  description = "Details for all worker nodes."
  value = module.ubunut-k8s-1.worker_nodes
}

output "all_node_vmids" {
  description = "Map of logical node names to assigned VMIDs."
  value       = module.ubunut-k8s-1.all_node_vmids
}