output "master_nodes" {
  description = "Details for all Talos control-plane nodes."
  value = {
    for name, node in local.nodes :
    name => {
      role          = lookup(node, "role", null)
      vm_id         = module.talos_nodes[name].vm_id
      vm_name       = lookup(node, "vm_name", null)
      planned_ip    = lookup(node, "ip_address", null)
      mac_address   = try(module.talos_nodes[name].mac_address, null)
      assigned_ip   = try(module.talos_nodes[name].ip_address, null)
      proxmox_node  = var.target_node
    }
    if lookup(node, "role", "") == "master"
  }
}

output "worker_nodes" {
  description = "Details for all Talos worker nodes."
  value = {
    for name, node in local.nodes :
    name => {
      role          = lookup(node, "role", null)
      vm_id         = module.talos_nodes[name].vm_id
      vm_name       = lookup(node, "vm_name", null)
      planned_ip    = lookup(node, "ip_address", null)
      mac_address   = try(module.talos_nodes[name].mac_address, null)
      assigned_ip   = try(module.talos_nodes[name].ip_address, null)
      proxmox_node  = var.target_node
    }
    if lookup(node, "role", "") == "worker"
  }
}

output "all_node_vmids" {
  description = "Map of logical node names to their VMIDs."
  value       = { for name, mod in module.talos_nodes : name => mod.vm_id }
}

output "planned_node_ips" {
  description = "Map of node names to their planned static IP addresses."
  value       = { for name, node in local.nodes : name => lookup(node, "ip_address", null) }
}

output "gateway" {
  description = "Gateway used for the Talos cluster subnet."
  value       = local.gateway
}