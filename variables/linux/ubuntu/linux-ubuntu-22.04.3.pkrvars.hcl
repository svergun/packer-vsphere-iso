vmware_vm_cpu             = 2
vmware_vm_cpu_cores       = 1
vmware_vm_cpu_hot_plug    = true
vmware_vm_ram             = 2048
vmware_vm_ram_reserve_all = false
vmware_vm_ram_hot_plug    = true
vmware_vm_disk_size       = 10240
vmware_vm_guest_os_type   = "ubuntu64Guest"

os_distr_version        = "22.04.3"
os_distr_name           = "ubuntu-linux"
vmware_iso_url          = "http://mirror.cogentco.com/pub/linux/ubuntu-releases/22.04/ubuntu-22.04.3-live-server-amd64.iso"
vmware_iso_url_checksum = "file:http://mirror.cogentco.com/pub/linux/ubuntu-releases/22.04/SHA256SUMS"
vmware_iso_cleanup_remote_cache = true

vmware_cl_tmpl_name  = "ubuntu-linux"
vmware_cl_tmpl_descr = "Ubuntu Linux Server 22.04.3 Standard Installation"

os_boot_command = "c<wait>linux /casper/vmlinuz --- autoinstall ds=\"nocloud-net;seedfrom=http://{{.HTTPIP}}:{{.HTTPPort}}/autoinstall-ubuntu-22.04.3/\"<enter><wait>initrd /casper/initrd<enter><wait>boot<enter>"
