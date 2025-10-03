output "master_nodes" {
  description = "Details for all master nodes."
  value = {
    for name, node in local.nodes :
    name => {
      role         = lookup(node, "role", null)
      vm_id        = module.nodes[name].vm_id
      vm_name      = lookup(node, "vm_name", null)
      ip           = lookup(node, "ip_address", null)
      proxmox_node = module.nodes[name].vm_node
    }
    if lookup(node, "role", "") == "master"
  }
}

output "worker_nodes" {
  description = "Details for all worker nodes."
  value = {
    for name, node in local.nodes :
    name => {
      role         = lookup(node, "role", null)
      vm_id        = module.nodes[name].vm_id
      vm_name      = lookup(node, "vm_name", null)
      ip           = lookup(node, "ip_address", null)
      proxmox_node = module.nodes[name].vm_node
    }
    if lookup(node, "role", "") == "worker"
  }
}

output "all_node_vmids" {
  description = "Map of logical node names to assigned VMIDs."
  value       = { for name, mod in module.nodes : name => mod.vm_id }
}

output "gateway" {
  description = "Gateway address used for the cluster network."
  value       = local.gateway
}