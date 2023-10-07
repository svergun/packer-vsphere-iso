packer {
  required_plugins {
    vsphere = {
      version = ">= 1.2.1"
      source  = "github.com/hashicorp/vsphere"
    }
  }
}