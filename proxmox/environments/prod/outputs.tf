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

# Talos K8s Cluster Output
output "master_nodes" {
  description = "Details for all Talos control-plane nodes."
  value = module.talos-k8s-1.master_nodes
}

output "worker_nodes" {
  description = "Details for all Talos worker nodes."
  value = module.talos-k8s-1.worker_nodes
}

output "all_node_vmids" {
  description = "Map of logical node names to their VMIDs."
  value       = module.talos-k8s-1.all_node_vmids
}

output "planned_node_ips" {
  description = "Map of node names to their planned static IP addresses."
  value       = module.talos-k8s-1.planned_node_ips
}