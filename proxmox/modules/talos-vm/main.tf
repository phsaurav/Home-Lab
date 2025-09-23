
resource "proxmox_vm_qemu" "talos-vm" {
  name        = var.vm_name
  target_node = var.target_node
  vmid        = var.vmid
  pool        = var.pool
  vm_state    = var.vm_state

  # Clone settings
  clone      = var.clone_template
  full_clone = var.full_clone


  # Resource allocation
  memory = var.memory
  cpu {
    cores   = var.cpu_cores
    limit = 0
    numa = false
    sockets = 1
    type = "x86-64-v2-AES"
  }

  # System settings
  machine = "q35"
  qemu_os = "l26"
  scsihw  = "virtio-scsi-single"

  # Boot and startup
  boot   = var.boot_order
  onboot = var.onboot

  # Agent and connection settings
  agent                  = var.qemu_agent
  define_connection_info = true
  clone_wait            = 10
  additional_wait       = 5

  # Disk configuration
  disks {
    scsi {
      scsi0 {
        disk {
          size     = var.disk_size
          storage  = var.disk_storage
          format    = "raw"
          iothread  = true
          discard   = true
          cache     = "none"
          backup    = true
          emulatessd = true
          readonly = false
        }
      }
    }
    ide {
      ide2 {
        cdrom {
          iso = var.iso_file
        }
      }
    }
  }

  # Network configuration
  network {
    id= 0
    model     = var.network_model
    bridge    = var.network_bridge
    firewall  = var.network_firewall
    link_down = false
  }

  # Serial console
  serial {
    id   = 0
    type = "socket"
  }


  # Tags and description
  tags = var.tags
}
