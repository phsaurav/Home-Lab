terraform {
  required_version = "~> 1.13.0"
required_providers {
    proxmox = {
      source = "Telmate/proxmox"
      version = "3.0.2-rc04"
    }
  }
}