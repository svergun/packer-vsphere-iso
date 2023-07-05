packer {
  required_plugins {
    vsphere = {
      version = ">= 1.1.1"
      source  = "github.com/hashicorp/vsphere"
    }
  }
}