build {
  sources = ["source.vsphere-iso.linux-server"]

  provisioner "shell" {
    script = "./scripts/${var.os_distr_family}-${var.os_distr_version}.sh"
  }

}