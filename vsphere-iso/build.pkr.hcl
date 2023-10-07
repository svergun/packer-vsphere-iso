build {
  sources = ["source.vsphere-iso.vsphere-build"]

  provisioner "shell" {
    script = "./scripts/${var.os_distr_name}-${var.os_distr_version}.sh"
  }

}