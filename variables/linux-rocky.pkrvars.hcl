vmware_vm_cpu           = 1
vmware_vm_cpu_cores     = 1
vmware_vm_ram           = 2048
vmware_vm_disk_size     = 10240
vmware_vm_guest_os_type = "centos9_64Guest"
vmware_cl_tmpl_descr    = "Rocky Linux Server Minimal Installation."
os_boot_command         = "<tab> text inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/autoinstall-rocky-server.cfg <enter><wait>"
