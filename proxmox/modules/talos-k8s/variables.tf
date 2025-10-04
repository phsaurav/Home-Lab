variable "cluster_id" {
  description = "Numeric identifier for the cluster (used in VMIDs/IPs)."
  type        = number

  validation {
    condition     = var.cluster_id >= 1
    error_message = "cluster_id must be at least 1."
  }
}

variable "cluster_name" {
  description = "Prefix used for VM names."
  type        = string
  default     = "talos-k8s"
}

variable "master_count" {
  description = "Number of Talos control plane nodes."
  type        = number
  default     = 1

  validation {
    condition     = var.master_count >= 1
    error_message = "At least one master node is required."
  }
}

variable "worker_count" {
  description = "Number of Talos worker nodes."
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
  description = "Gateway IP; defaults to the .1 host of the CIDR."
  type        = string
}

variable "target_node" {
  description = "Proxmox node for all VMs."
  type        = string
  default     = "proxmox"
}

variable "pool" {
  description = "Proxmox resource pool."
  type        = string
}

variable "vm_state" {
  description = "Desired post-creation state."
  type        = string
  default     = "stopped"
}

variable "clone_template" {
  description = "Template to clone for Talos nodes."
  type        = string
}

variable "full_clone" {
  description = "Whether to use full clones."
  type        = bool
  default     = true
}

variable "master_memory" {
  description = "Memory (MB) for each master."
  type        = number
  default     = 4096
}

variable "master_cpu_cores" {
  description = "CPU cores for each master."
  type        = number
  default     = 2
}

variable "master_disk_size" {
  description = "Disk size for master nodes (e.g. \"20G\")."
  type        = string
  default     = "10G"
}

variable "worker_memory" {
  description = "Memory (MB) for each worker."
  type        = number
  default     = 4096
}

variable "worker_cpu_cores" {
  description = "CPU cores for each worker."
  type        = number
  default     = 2
}

variable "worker_disk_size" {
  description = "Disk size for worker nodes."
  type        = string
  default     = "10G"
}

variable "disk_storage" {
  description = "Proxmox storage for the primary disks."
  type        = string
  default     = "local-lvm"
}

variable "iso_file" {
  description = "Talos ISO path/ID to attach."
  type        = string
  default     = "local:iso/talos-metal-amd64.iso"
}

variable "boot_order" {
  description = "Boot order string for Talos VMs."
  type        = string
  default     = "order=scsi0;ide2"
}

variable "onboot" {
  description = "Auto-start VM when Proxmox boots."
  type        = bool
  default     = true
}

variable "qemu_agent" {
  description = "Enable QEMU guest agent."
  type        = number
  default     = 1
}

variable "network_model" {
  description = "NIC model."
  type        = string
  default     = "virtio"
}

variable "network_bridge" {
  description = "Bridge to attach NICs to."
  type        = string
  default     = "vmbr0"
}

variable "network_firewall" {
  description = "Enable Proxmox firewall on NICs."
  type        = bool
  default     = true
}

variable "common_tags" {
  description = "Tags applied to every Talos node."
  type        = list(string)
  default     = ["talos", "k8s"]
}

variable "master_tags" {
  description = "Additional tags for masters."
  type        = list(string)
  default     = ["master"]
}

variable "worker_tags" {
  description = "Additional tags for workers."
  type        = list(string)
  default     = ["worker"]
}