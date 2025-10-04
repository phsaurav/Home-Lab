locals {
  gateway       = coalesce(var.gateway, cidrhost(var.network_cidr, 1))

  master_nodes = {
    for idx in range(var.master_count) :
    format("master-%02d", idx + 1) => {
      role       = "master"
      sequence   = idx + 1
      vm_name    = format("%s-master-%02d", var.cluster_name, idx + 1)
      vmid       = tonumber(format("%d1%02d", var.cluster_id, idx + 1))
      ip_address = cidrhost(var.network_cidr, 100 + idx + 1)
      memory     = var.master_memory
      cpu_cores  = var.master_cpu_cores
      disk_size  = var.master_disk_size
      tags       = concat(var.common_tags, var.master_tags)
    }
  }

  worker_nodes = {
    for idx in range(var.worker_count) :
    format("worker-%02d", idx + 1) => {
      role       = "worker"
      sequence   = idx + 1
      vm_name    = format("%s-worker-%02d", var.cluster_name, idx + 1)
      vmid       = tonumber(format("%d2%02d", var.cluster_id, idx + 1))
      ip_address = cidrhost(var.network_cidr, 200 + idx + 1)
      memory     = var.worker_memory
      cpu_cores  = var.worker_cpu_cores
      disk_size  = var.worker_disk_size
      tags       = concat(var.common_tags, var.worker_tags)
    }
  }

  nodes = merge(local.master_nodes, local.worker_nodes)
}

module "talos_nodes" {
  source   = "../talos-vm"
  for_each = local.nodes

  vm_name     = lookup(each.value, "vm_name", null)
  target_node = var.target_node
  vmid        = lookup(each.value, "vmid", null)
  pool        = var.pool
  vm_state    = var.vm_state

  clone_template = var.clone_template
  full_clone     = var.full_clone

  memory    = lookup(each.value, "memory", null)
  cpu_cores = lookup(each.value, "cpu_cores", null)
  disk_size = lookup(each.value, "disk_size", null)

  disk_storage = var.disk_storage
  iso_file     = var.iso_file

  boot_order = var.boot_order
  onboot     = var.onboot
  qemu_agent = var.qemu_agent

  network_bridge   = var.network_bridge
  network_firewall = var.network_firewall
  network_model    = var.network_model

  tags = join(";", distinct(lookup(each.value, "tags", [])))
}