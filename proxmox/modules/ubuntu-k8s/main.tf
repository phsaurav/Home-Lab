locals {
  cidr_parts    = split("/", var.network_cidr)
  prefix_length = tonumber(local.cidr_parts[1])
  gateway       = coalesce(var.gateway, cidrhost(var.network_cidr, 1))

  master_nodes = {
    for idx in range(var.master_count) :
    format("master-%02d", idx + 1) => {
      role       = "master"
      role_code  = 1
      sequence   = idx + 1
      vm_name    = format("%s-master-%02d", var.cluster_name, idx + 1)
      vmid       = tonumber(format("%d1%02d", var.cluster_id, idx + 1))
      ip_address = cidrhost(var.network_cidr, 100 + idx + 1)
      memory     = var.master_memory
      cpu_cores  = var.master_cpu_cores
      disk_size  = var.master_disk_size
    }
  }

  worker_nodes = {
    for idx in range(var.worker_count) :
    format("worker-%02d", idx + 1) => {
      role       = "worker"
      role_code  = 2
      sequence   = idx + 1
      vm_name    = format("%s-worker-%02d", var.cluster_name, idx + 1)
      vmid       = tonumber(format("%d2%02d", var.cluster_id, idx + 1))
      ip_address = cidrhost(var.network_cidr, 200 + idx + 1)
      memory     = var.worker_memory
      cpu_cores  = var.worker_cpu_cores
      disk_size  = var.worker_disk_size
    }
  }

  nodes = merge(local.master_nodes, local.worker_nodes)
}

# noinspection HILUnresolvedReference
module "nodes" {
  source  = "../ubuntu-vm"
  for_each = local.nodes

  vm_name     = each.value.vm_name
  target_node = var.target_node
  vmid        = each.value.vmid
  pool        = var.pool
  vm_state    = var.vm_state

  clone_template = var.clone_template
  full_clone     = var.full_clone

  memory     = each.value.memory
  cpu_cores  = each.value.cpu_cores
  disk_size  = each.value.disk_size

  disk_storage      = var.disk_storage
  cloudinit_storage = var.cloudinit_storage
  cicustom          = var.cicustom

  network_bridge   = var.network_bridge
  network_firewall = var.network_firewall
  onboot           = var.onboot

  ci_user        = var.ci_user
  ci_password    = var.ci_password
  ssh_public_key = var.ssh_public_key

  ip_config = format("ip=%s/%d,gw=%s", each.value.ip_address, local.prefix_length, local.gateway)
  vm_ip     = each.value.ip_address

  enable_provisioners  = var.enable_basic_setup
  ssh_private_key_path = var.ssh_private_key_path
  provisioner_commands = var.provisioner_commands

  tags = join(
    ";",
    distinct(
      concat(
        var.common_tags,
        each.value.role == "master" ? var.master_tags : var.worker_tags
      )
    )
  )
}