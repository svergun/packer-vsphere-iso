build {
  sources = ["source.vsphere-iso.vsphere-build"]

  provisioner "shell" {
    script = "./scripts/${var.os_distr_name}.sh"
  }

}