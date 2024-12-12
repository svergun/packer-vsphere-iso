variable "os_distr_version" {
  type    = string
  default = ""
}

variable "os_distr_name" {
  type    = string
  default = ""
}

variable "os_boot_command" {
  type    = string
  default = ""
}

variable "vmware_iso_url" {
  type    = string
  default = ""
}

variable "vmware_iso_url_checksum" {
  type    = string
  default = ""
}

variable "vmware_vcenter_server" {
  type    = string
  default = ""
}

variable "vmware_resource_pool" {
  type    = string
  default = ""
}

variable "vmware_datacenter" {
  type    = string
  default = ""
}

variable "vmware_username" {
  type    = string
  default = ""
}

variable "vmware_password" {
  type      = string
  sensitive = true
  default   = ""
}

variable "vmware_insecure_connection" {
  type    = bool
  default = false
}

variable "vmware_vm_cpu" {
  type    = number
  default = 1
}

variable "vmware_vm_cpu_cores" {
  type    = number
  default = 1
}

variable "vmware_vm_cpu_hot_plug" {
  type    = bool
  default = true
}

variable "vmware_vm_ram" {
  type    = number
  default = 2048
}

variable "vmware_vm_ram_reserve_all" {
  type    = bool
  default = false
}

variable "vmware_vm_ram_hot_plug" {
  type    = bool
  default = true
}

variable "vmware_vm_name" {
  type    = string
  default = ""
}

variable "vmware_vm_cluster" {
  type    = string
  default = ""
}

variable "vmware_vm_datastore" {
  type    = string
  default = ""
}

variable "vmware_vm_version" {
  type    = number
  default = 21
}

variable "vmware_vm_guest_os_type" {
  type    = string
  default = ""
}

variable "vmware_vm_destroy" {
  type    = bool
  default = false
}

variable "vmware_vm_network" {
  type    = string
  default = ""
}

variable "vmware_vm_network_card" {
  type    = string
  default = ""
}

variable "vmware_vm_disk_controller_type" {
  type    = string
  default = ""
}

variable "vmware_vm_disk_size" {
  type    = number
  default = 10240
}

variable "vmware_vm_disk_thin_provisioner" {
  type    = bool
  default = true
}

variable "vmware_ssh_username" {
  type    = string
  default = "admin"
}

variable "vmware_ssh_password" {
  type    = string
  default = "admin"
}

variable "vmware_cl_name" {
  type    = string
  default = ""
}

variable "vmware_cl_tmpl_name" {
  type    = string
  default = ""
}

variable "vmware_cl_tmpl_descr" {
  type    = string
  default = ""
}

variable "vmware_cl_vm_destroy" {
  type    = bool
  default = true
}

variable "vmware_cl_ovf" {
  type    = bool
  default = true
}
