vmware_vm_cpu           = 1
vmware_vm_ram           = 2048
vmware_vm_disk_size     = 10240
vmware_vm_guest_os_type = "ubuntu64Guest"
vmware_cl_tmpl_descr    = "Ubuntu Linux Server Minimal Installation."
os_boot_command         = "c<wait>linux /casper/vmlinuz --- autoinstall ds=\"nocloud-net;seedfrom=http://{{.HTTPIP}}:{{.HTTPPort}}/autoinstall-ubuntu-server/\"<enter><wait>initrd /casper/initrd<enter><wait>boot<enter>"
