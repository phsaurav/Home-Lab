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
  default     = "order=scsi0"
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


variable "cloudinit_storage" {
  description = "Storage for cloud-init disk"
  type        = string
  default     = "local-lvm"
}

# Cloud-init Custom Configuration
variable "cicustom" {
  description = "Cloud-init custom configuration (user=local:snippets/user-data-ubuntu.yaml)"
  type        = string
  default     = null
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


# Cloud-init Settings
variable "ci_user" {
  description = "Cloud-init user"
  type        = string
}

variable "ci_password" {
  description = "Cloud-init password"
  type        = string
  sensitive   = true
}


variable "ip_config" {
  description = "IP configuration (ipconfig0)"
  type        = string
  default     = "dhcp"
}

variable "vm_ip" {
  description = "VM IP address (for provisioners)"
  type        = string
  default     = ""
}

# Tags
variable "tags" {
  description = "VM tags"
  type        = string
  default     = "ubuntu"
}

# Provisioner Configuration
variable "enable_provisioners" {
  description = "Enable provisioners for post-deployment configuration"
  type        = bool
  default     = false
}

variable "ssh_private_key_path" {
  description = "Path to SSH private key"
  type        = string
}

variable "ssh_public_key" {
  description = "SSH public key for adding it to autorized key"
  type  = string
  default = ""
}

variable "ssh_port" {
  description = "SSH port"
  type        = number
  default     = 22
}

variable "ssh_timeout" {
  description = "SSH timeout"
  type        = string
  default     = "3m"
}

variable "provisioner_commands" {
  description = "Commands to run via remote-exec provisioner"
  type        = list(string)
  default = [
    "sudo apt update && sudo apt dist-upgrade -y"
  ]
}