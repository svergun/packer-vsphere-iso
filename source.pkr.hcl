locals {
  timestamp            = regex_replace(timestamp(), "[- TZ:]", "")
  vmware_cl_tmpl_name  = "${var.vmware_cl_tmpl_name}-${var.os_distr_version}-tmpl"
  vmware_cl_tmpl_descr = "${var.vmware_cl_tmpl_descr}, User: ${var.vmware_ssh_username}, Password: ${var.vmware_ssh_password}"
}

source "vsphere-iso" "vsphere-build" {
  # Connection Configuration
  vcenter_server      = var.vmware_vcenter_server
  resource_pool       = var.vmware_resource_pool
  datacenter          = var.vmware_datacenter
  username            = var.vmware_username
  password            = var.vmware_password
  insecure_connection = var.vmware_insecure_connection

  # Hardware Configuration
  CPUs            = var.vmware_vm_cpu
  cpu_cores       = var.vmware_vm_cpu_cores
  CPU_hot_plug    = var.vmware_vm_cpu_hot_plug
  RAM             = var.vmware_vm_ram
  RAM_reserve_all = var.vmware_vm_ram_reserve_all
  RAM_hot_plug    = var.vmware_vm_ram_hot_plug

  # Location Configuration
  vm_name   = "${var.vmware_vm_name}-${var.os_distr_name}-${var.os_distr_version}-${local.timestamp}"
  cluster   = var.vmware_vm_cluster
  datastore = var.vmware_vm_datastore

  # ISO Configuration
  iso_url      = var.vmware_iso_url
  iso_checksum = var.vmware_iso_url_checksum

  # Create Configuration
  vm_version    = var.vmware_vm_version
  guest_os_type = var.vmware_vm_guest_os_type
  destroy       = var.vmware_vm_destroy
  # Network Adapter Configuration
  network_adapters {
    network      = var.vmware_vm_network
    network_card = var.vmware_vm_network_card
  }
  # Storage Configuration
  disk_controller_type = [var.vmware_vm_disk_controller_type]
  storage {
    disk_size             = var.vmware_vm_disk_size
    disk_thin_provisioned = var.vmware_vm_disk_thin_provisioner
  }
  # Kickstart Configuration
  http_directory = "http"
  boot_command   = [var.os_boot_command]

  # Communicator configuration
  ssh_username = var.vmware_ssh_username
  ssh_password = var.vmware_ssh_password
  ssh_timeout  = "30m"
  # Shutdown VM
  shutdown_command = "sudo /sbin/halt -h -p"
  # Create a content library template
  content_library_destination {
    library     = var.vmware_cl_name
    name        = local.vmware_cl_tmpl_name
    description = local.vmware_cl_tmpl_descr
    destroy     = var.vmware_cl_vm_destroy
    ovf         = var.vmware_cl_ovf
  }
}