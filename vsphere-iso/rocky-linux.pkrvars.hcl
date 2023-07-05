vmware_vcenter_server      = "vcenter.lab.vergun.net"
vmware_resource_pool       = "vLAB-RP"
vmware_datacenter          = "vLAB-DC"
vmware_username            = "administrator@lab.vergun.net"
vmware_insecure_connection = true

vmware_vm_cpu                   = 1
vmware_vm_cpu_cores             = 1
vmware_vm_cpu_hot_plug          = true
vmware_vm_ram                   = 2048
vmware_vm_ram_reserve_all       = false
vmware_vm_ram_hot_plug          = true
vmware_vm_name                  = "packer-build"
vmware_vm_cluster               = "vLAB-CL"
vmware_vm_datastore             = "vDS-ESXi-2-NVMe"
vmware_vm_version               = 20
vmware_vm_guest_os_type         = "centos9_64Guest"
vmware_vm_destroy               = false
vmware_vm_network               = "vLAB-DSW-VM Network"
vmware_vm_network_card          = "vmxnet3"
vmware_vm_disk_controller_type  = "pvscsi"
vmware_vm_disk_size             = 10240
vmware_vm_disk_thin_provisioner = true

os_distr_version = "9"
os_distr_family  = "rhel" # valid values: rhel
os_iso_base_url  = "https://download.rockylinux.org/pub/rocky"
os_iso_path      = "isos/x86_64"
os_iso_name      = "Rocky-x86_64-minimal.iso"

vmware_ssh_username = "admin"
vmware_ssh_password = "admin"

vmware_cl_name       = "vLIB-NAS-MAIN"
vmware_cl_tmpl_name  = "rocky-linux"
vmware_cl_cluster    = "vLAB-CL"
vmware_cl_folder     = "vTEMPLATE"
vmware_cl_datastore  = "vDS-NAS-MAIN-LUN1"
vmware_cl_vm_destroy = true
