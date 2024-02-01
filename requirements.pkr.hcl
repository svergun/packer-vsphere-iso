packer {
  required_plugins {
    vsphere = {
      version = ">= 1.2.4"
      source  = "github.com/hashicorp/vsphere"
    }
  }
}