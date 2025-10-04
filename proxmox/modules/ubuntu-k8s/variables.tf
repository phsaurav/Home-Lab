variable "cluster_id" {
  description = "Numeric identifier for the cluster (used in VMIDs/IPs)."
  type        = number

  validation {
    condition     = var.cluster_id >= 1
    error_message = "cluster_id must be greater than or equal to 1."
  }
}

variable "cluster_name" {
  description = "Prefix used for VM names."
  type        = string
}

variable "master_count" {
  description = "Number of control-plane nodes."
  type        = number
  default     = 1

  validation {
    condition     = var.master_count >= 1
    error_message = "At least one master node is required."
  }
}

variable "worker_count" {
  description = "Number of worker nodes."
  type        = number
  default     = 2

  validation {
    condition     = var.worker_count >= 0
    error_message = "worker_count must be zero or greater."
  }
}

variable "network_cidr" {
  description = "CIDR for the cluster network (e.g. 192.168.11.0/24)."
  type        = string
}

variable "gateway" {
  description = "Gateway IP for the cluster network. Defaults to the .1 host of the CIDR."
  type        = string
  default     = null
}

variable "target_node" {
  description = "Proxmox node to deploy VMs on."
  type        = string
  default     = "proxmox"
}

variable "pool" {
  description = "Proxmox resource pool."
  type        = string
}

variable "vm_state" {
  description = "Desired state of each VM after creation."
  type        = string
  default     = "stopped"
}

variable "clone_template" {
  description = "Template to clone for all nodes."
  type        = string
}

variable "full_clone" {
  description = "Whether to use full clones."
  type        = bool
  default     = true
}

variable "master_memory" {
  description = "Memory (MB) for master nodes."
  type        = number
  default     = 4096
}

variable "master_cpu_cores" {
  description = "CPU cores for master nodes."
  type        = number
  default     = 2
}

variable "master_disk_size" {
  description = "Disk size for master nodes (e.g. \"20G\")."
  type        = string
  default     = "10G"
}

variable "worker_memory" {
  description = "Memory (MB) for worker nodes."
  type        = number
  default     = 4096
}

variable "worker_cpu_cores" {
  description = "CPU cores for worker nodes."
  type        = number
  default     = 2
}

variable "worker_disk_size" {
  description = "Disk size for worker nodes (e.g. \"20G\")."
  type        = string
  default     = "10G"
}

variable "disk_storage" {
  description = "Proxmox storage for primary disks."
  type        = string
  default     = "local-lvm"
}

variable "cloudinit_storage" {
  description = "Storage for cloud-init disks."
  type        = string
  default     = "local-lvm"
}

variable "network_bridge" {
  description = "Bridge to attach VM NICs to."
  type        = string
  default     = "vmbr0"
}

variable "network_firewall" {
  description = "Enable the Proxmox firewall on VM NICs."
  type        = bool
  default     = true
}

variable "onboot" {
  description = "Start VMs automatically when Proxmox boots."
  type        = bool
  default     = false
}

variable "cicustom" {
  description = "Optional cloud-init snippet reference."
  type        = string
  default     = null
}

variable "ci_user" {
  description = "Cloud-init user."
  type        = string
}

variable "ci_password" {
  description = "Cloud-init password."
  type        = string
  sensitive   = true
}

variable "ssh_public_key" {
  description = "SSH public key injected via cloud-init."
  type        = string
  default     = ""
}

variable "ssh_private_key_path" {
  description = "Private key path for optional provisioning."
  type        = string
  default     = ""
}

variable "enable_basic_setup" {
  description = "Toggle remote provisioners (uses ssh_private_key_path)."
  type        = bool
  default     = false
}

variable "provisioner_commands" {
  description = "Commands to execute when basic setup is enabled."
  type        = list(string)
  default     = [
    "sudo apt update -y",
    "sudo apt dist-upgrade -y"
  ]
}

variable "common_tags" {
  description = "Tags applied to every node."
  type        = list(string)
  default     = ["ubuntu", "k8s"]
}

variable "master_tags" {
  description = "Additional tags for master nodes."
  type        = list(string)
  default     = ["master"]
}

variable "worker_tags" {
  description = "Additional tags for worker nodes."
  type        = list(string)
  default     = ["worker"]
}