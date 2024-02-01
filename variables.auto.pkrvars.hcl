vmware_vcenter_server      = "vcenter.lab.vergun.net"
vmware_resource_pool       = "vLAB-RP"
vmware_datacenter          = "vLAB-DC"
vmware_username            = "administrator@lab.vergun.net"
vmware_insecure_connection = true

vmware_vm_name                  = "packer"
vmware_vm_cluster               = "vLAB-CL"
vmware_vm_datastore             = "vDS-ESXi-1-NVMe"
vmware_vm_version               = 20
vmware_vm_destroy               = false
vmware_vm_network               = "vLAB-DSW-VM Network"
vmware_vm_network_card          = "vmxnet3"
vmware_vm_disk_controller_type  = "pvscsi"
vmware_vm_disk_thin_provisioner = true

vmware_ssh_username = "packer"
vmware_ssh_password = "packer"

vmware_cl_name       = "vLIB-PACKER"
vmware_cl_vm_destroy = true
vmware_cl_ovf        = true
