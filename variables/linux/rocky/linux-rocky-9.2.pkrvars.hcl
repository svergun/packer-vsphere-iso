vmware_vm_cpu             = 1
vmware_vm_cpu_cores       = 1
vmware_vm_cpu_hot_plug    = true
vmware_vm_ram             = 2048
vmware_vm_ram_reserve_all = false
vmware_vm_ram_hot_plug    = true
vmware_vm_disk_size       = 10240
vmware_vm_guest_os_type   = "centos9_64Guest"

os_distr_version        = "9.2"
os_distr_name           = "rocky-linux"
vmware_iso_url          = "https://dl.rockylinux.org/vault/rocky/9.2/isos/x86_64/Rocky-9.2-x86_64-minimal.iso"
vmware_iso_url_checksum = "file:https://dl.rockylinux.org/vault/rocky/9.2/isos/x86_64/CHECKSUM"

vmware_cl_tmpl_name  = "rocky-linux"
vmware_cl_tmpl_descr = "Rocky Linux Minimal Installation"

os_boot_command = "<tab> text inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/autoinstall-rocky-linux-9.2.cfg <enter><wait>"