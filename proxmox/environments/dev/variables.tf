variable "project" {
  description = "Proxmox Project Name"
  type        = string
}

variable "environment" {
  description = "Environment Name"
  type        = string

  # validation {
  #   condition     = var.environment == terraform.workspace
  #   error_message = "Workspace & Variable File Inconsistency!! Please Double Check!!"
  # }
}

# ProxMox Variable
variable "pm_api_url" {
  description = "Proxmox API URL"
  type        = string
}

variable "pm_api_token_id" {
  description = "Proxmox API Token ID"
  type        = string
}

variable "pm_api_token_secret" {
  description = "Proxmox API Token Secret"
  type        = string
}

# Ubuntu VM variables
# Cloud-init
variable "ci_user" {
  description = "Cloud-init user"
  type        = string
}

variable "ci_password" {
  description = "Cloud-init password"
  type        = string
  sensitive   = true
}

variable "ssh_private_key_path" {
  description = "Path to SSH private key"
  type        = string
}

variable "ssh_public_key" {
  description = "SSH public key for adding it to autorized key"
  type        = string
  default     = ""
}

# ubuntu VM variables
variable "ub_ip_config" {
  description = "ubuntu VM IP configuration (ipconfig0)"
  type        = string
}

variable "ub_vm_ip" {
  description = "ubuntu VM IP address (for provisioners)"
  type        = string
}

# ubuntu-2 VM variables
variable "ub_2_ip_config" {
  description = "ubuntu-2 VM IP configuration (ipconfig0)"
  type        = string
}

variable "ub_2_vm_ip" {
  description = "ubuntu-2 VM IP address (for provisioners)"
  type        = string
}

# Ubuntu-K8s Variables
variable "gateway" {
  description = "LXC Container Gateway"
  type        = string
}

variable "ub_k8s_cidr" {
  description = "ubuntu VM IP configuration (ipconfig0)"
  type        = string
}

# LXC Container Variables (for n8n)
variable "lxc_pass" {
  description = "LXC Container Password"
  type        = string
  sensitive   = true
}

variable "n8n_ip" {
  description = "n8n Container IP"
  type        = string
  default     = "dhcp"
}

# OpenClaw VM Variables
variable "openclaw_ip" {
  description = "OpenClaw VM IP with CIDR (e.g. '192.168.10.69/24')"
  type        = string
}