vmware_vm_cpu             = 1
vmware_vm_cpu_cores       = 1
vmware_vm_cpu_hot_plug    = true
vmware_vm_ram             = 2048
vmware_vm_ram_reserve_all = false
vmware_vm_ram_hot_plug    = true
vmware_vm_disk_size       = 10240
vmware_vm_guest_os_type   = "debian12_64Guest"

os_distr_version        = "12.1.0"
os_distr_name           = "debian-linux"
vmware_iso_url          = "http://cdimage.debian.org/mirror/cdimage/archive/12.1.0/amd64/iso-cd/debian-12.1.0-amd64-netinst.iso"
vmware_iso_url_checksum = "file:http://cdimage.debian.org/mirror/cdimage/archive/12.1.0/amd64/iso-cd/SHA256SUMS"
vmware_iso_cleanup_remote_cache = true

vmware_cl_tmpl_name  = "debian-linux"
vmware_cl_tmpl_descr = "Debian Linux 12.1.0 Minimal Installation"

os_boot_command = "<esc>auto preseed/url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/autoinstall-debian-linux-12.1.0.cfg<enter>"
