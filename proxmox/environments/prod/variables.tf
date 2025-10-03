variable "project" {
  description = "Proxmox Project Name"
  type = string
}

variable "environment" {
  description = "Environment Name"
  type        = string

  # validation {
  #   condition     = var.environment == terraform.workspace
  #   error_message = "Workspace & Variable File Inconsistency!! Please Double Check!!"
  # }
}

#Ubuntu Cluster Variable
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

variable "ub_k8s_network_cidr" {
  description = "ubuntu VM IP configuration (ipconfig0)"
  type        = string
}


# ProxMox Variable
variable "pm_api_url" {
  description = "Proxmox API URL"
  type = string
}

variable "pm_api_token_id" {
  description = "Proxmox API Token ID"
  type = string
}

variable "pm_api_token_secret" {
  description = "Proxmox API Token Secret"
  type  = string
}

# Turnkey NAS Variable
variable "lxc_pass" {
  description = "Turnkey Container Password"
  type        = string
  sensitive   = true
}

variable "gateway" {
  description = "LXC Container Gateway"
  type        = string
}

variable "tk_nas_ip" {
  description = "Turnkey NAS container IP"
  type        = string
  default     = "dhcp"
}

# Pi-Hole variables
variable "pi_hole_ip" {
  description = "PI Hole Container IP"
  type        = string
  default     = "dhcp"
}

# n8n variables
variable "n8n_ip" {
  description = "n8n Container IP"
  type        = string
  default     = "dhcp"
}