# LXC Basic Configuration
variable "vmid" {
  description = "LXC container ID (must be unique)"
  type        = number
}

variable "target_node" {
  description = "Proxmox node to deploy LXC container on"
  type        = string
  default     = "proxmox"
}

variable "hostname" {
  description = "Hostname of the LXC container"
  type        = string
}

variable "ostemplate" {
  description = "OS template for the LXC container"
  type        = string
}

variable "password" {
  description = "Root password for the LXC container"
  type        = string
  sensitive   = true
}

variable "pool" {
  description = "Resource pool for the LXC container"
  type        = string
  default     = null
}

# Container Settings
variable "unprivileged" {
  description = "Whether the container should be unprivileged"
  type        = bool
  default     = true
}

variable "start" {
  description = "Start the container after creation"
  type        = bool
  default     = true
}

variable "onboot" {
  description = "Start container on boot"
  type        = bool
  default     = true
}

# Resource Allocation
variable "cores" {
  description = "Number of CPU cores"
  type        = number
  default     = 2
}

variable "memory" {
  description = "Memory allocation in MB"
  type        = number
  default     = 1024
}

variable "swap" {
  description = "Swap allocation in MB"
  type        = number
  default     = 0
}

# Storage Configuration
variable "rootfs_storage" {
  description = "Storage location for root filesystem"
  type        = string
  default     = "local-lvm"
}

variable "rootfs_size" {
  description = "Size of root filesystem (e.g., '8G', '10G')"
  type        = string
  default     = "8G"
}

# Features
variable "features_enabled" {
  description = "Enable features block (set to false to disable all features)"
  type        = bool
  default     = true
}
variable "features" {
  description = "LXC container features configuration"
  type = object({
    fuse         = optional(bool)
    keyctl       = optional(bool)
    mount        = optional(string)
    nesting      = optional(bool)
  })
  default = {}

  validation {
    condition = var.features.mount == null || can(regex("^(proc|sys|cgroup)?.*$", var.features.mount))
    error_message = "Mount must be a valid mount specification."
  }
}

# Network Configuration
variable "network_name" {
  description = "Network interface name"
  type        = string
  default     = "eth0"
}

variable "network_bridge" {
  description = "Network bridge"
  type        = string
  default     = "vmbr0"
}

variable "network_ip" {
  description = "IP address with CIDR (e.g., '192.168.1.100/24' or 'dhcp')"
  type        = string
  default     = "dhcp"
}

variable "network_gw" {
  description = "Gateway address"
  type        = string
}

variable "network_ip6" {
  description = "IPv6 configuration"
  type        = string
  default     = "auto"
}

# Startup Configuration
variable "startup" {
  description = "Startup order and delay (e.g., 'order=10,up=30')"
  type        = string
  default     = null
}

# Tags
variable "tags" {
  description = "Container tags"
  type        = string
  default     = "lxc"
}