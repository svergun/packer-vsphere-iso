# Automate image builds

Create identical images for multiple platforms.

## Requirements

* VMware ESXi - 8+
* Packer - 1.9+

## VMware vSphere

Builds an OVF template and upload it to your VMware Content Library.

### Supported OS

* Rocky Linux 9

### Sensitive Data

To pass vCenter password:

* create the `.sensitive` folder
* create file `sensitive.pkrvars.hcl`
* define `vmware_password` variable (e.g. `vmware_password = "myPa$$word"`)

### Build

```shell
packer build --var-file=rocky-linux.pkrvars.hcl --var-file=.sensitive/sensitive.pkrvars.hcl .
```

Use `vsphere-iso/rocky-linux.pkrvars.hcl` file for customizing your ISO builging.