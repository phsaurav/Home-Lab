resource "proxmox_vm_qemu" "ubuntu_vm" {
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
  agent_timeout = 300
  skip_ipv6     = true

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
          replicate = true
        }
      }
    }
    ide {
      ide3 {
        cloudinit {
          storage = var.cloudinit_storage
        }
      }
    }
  }

  # Cloud-init configuration
  cicustom = var.cicustom

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

  # Cloud-init settings
  ciuser     = var.ci_user
  cipassword = var.ci_password
  sshkeys    = var.ssh_public_key
  ipconfig0  = var.ip_config

  # Tags
  tags = var.tags
}

resource "null_resource" "vm_provisioner" {
  count = var.enable_provisioners ? 1 : 0

  # Wait for VM to be ready
  provisioner "local-exec" {
    command = "for i in {1..30}; do nc -z ${var.vm_ip} 22 && echo 'SSH ready' && exit 0 || echo 'Waiting for SSH...' && sleep 10; done; exit 1"
  }

  # SSH connection for remote provisioning
  connection {
    type        = "ssh"
    host        = var.vm_ip
    user        = var.ci_user
    private_key = file(var.ssh_private_key_path)
    port        = var.ssh_port
    timeout     = var.ssh_timeout
  }

  # Run remote commands
  provisioner "remote-exec" {
    inline = var.provisioner_commands
  }

  # Ensure this runs after VM creation
  depends_on = [proxmox_vm_qemu.ubuntu_vm]
}
