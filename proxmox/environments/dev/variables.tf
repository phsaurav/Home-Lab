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
  type  = string
  default = ""
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
