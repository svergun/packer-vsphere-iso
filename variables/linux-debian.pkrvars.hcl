vmware_vm_cpu           = 2
vmware_vm_ram           = 4096
vmware_vm_disk_size     = 10240
vmware_vm_guest_os_type = "debian12_64Guest"
vmware_cl_tmpl_descr    = "Debian Linux Server Minimal Installation."
os_boot_command         = "<esc>auto preseed/url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/autoinstall-debian-server.cfg<enter>"
