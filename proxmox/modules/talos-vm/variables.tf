# VM Basic Configuration
variable "vm_name" {
  description = "Name of the VM"
  type        = string
}

variable "target_node" {
  description = "Proxmox node to deploy VM on"
  type        = string
  default     = "proxmox"
}

variable "vmid" {
  description = "VM ID (must be unique)"
  type        = number
}

variable "pool" {
  description = "Resource pool for the VM"
  type        = string
  default     = null
}

variable "vm_state" {
  description = "VM state after creation (running, stopped)"
  type        = string
  default = "running"
}

# Clone Configuration
variable "clone_template" {
  description = "Template to clone from"
  type        = string
}

variable "full_clone" {
  description = "Whether to perform a full clone"
  type        = bool
}

# Resource Allocation
variable "memory" {
  description = "Memory allocation in MB"
  type        = number
}

variable "cpu_cores" {
  description = "Number of CPU cores"
  type        = number
}

# Boot Configuration
variable "boot_order" {
  description = "Boot order"
  type        = string
  default     = "order=scsi0;ide2"
}

variable "onboot" {
  description = "Start VM on boot"
  type        = bool
}

# Agent and Connection
variable "qemu_agent" {
  description = "Enable QEMU agent"
  type        = number
  default     = 1
}


# Disk Configuration
variable "disk_size" {
  description = "Disk size (e.g., '10G', '20G')"
  type        = string
  default     = "10G"
}

variable "disk_storage" {
  description = "Storage location for disk"
  type        = string
  default     = "local-lvm"
}


variable "iso_file" {
  description = "Talso ISO file location"
  type        = string
  default     = "local:iso/talos-metal-amd64.iso"
}

# Network Configuration
variable "network_model" {
  description = "Network model"
  type        = string
  default     = "virtio"
}

variable "network_bridge" {
  description = "Network bridge"
  type        = string
  default     = "vmbr0"
}

variable "network_firewall" {
  description = "Enable firewall on network interface"
  type        = bool
  default     = true
}

# Tags
variable "tags" {
  description = "VM tags"
  type        = string
  default     = "ubuntu"
}
