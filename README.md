# Packer vSphere-ISO Builder Repository

Automate image builds to create identical virtual machine (VM) templates for VMware vSphere using the vSphere-ISO builder in Packer.

This repository is here to simplify creating VM templates and effortlessly uploading them to a VMware Content Library.

## Requirements

To use this repository, ensure you have the following prerequisites:

- **VMware ESXi:** Version 8 or later installed and configured. It was developed and tested with VMware ESXi 8.0 and higher.
- **Packer:** Version 1.9 or higher installed. It was developed and tested with Packer 1.9.0 and higher.

## Manage Packer Plugins

Packer plugins are managed using the `packer init` command. Describe the plugins you want to use in a `requirements.pkr.hcl` file and run `packer init` to install them. To upgrade installed  plugins after changing a pluging version in the file, run `packer init -upgrade .`.

Example:

```shell
> packer init -upgrade .
Installed plugin github.com/hashicorp/vsphere v1.2.1 in "/opt/homebrew/bin/github.com/hashicorp/vsphere/packer-plugin-vsphere_v1.2.1_x5.0_darwin_arm64"
```

## VMware vSphere-ISO Builder

The vSphere-ISO builder in Packer allows you to create VM templates for VMware vSphere environments. This builder is used to automate the process of creating VMs and converting them into templates for reuse.

### vSphere-ISO Variable Files

- `variables-vmware.auto.pkrvars.hcl` - this file contains the default values to connect to VMware vCenter, default values for the VM template and VMware Content Library.
  - `vmware_vcenter_server` - the IP address or hostname of the vCenter server.
  - `vmware_resource_pool` - the name of the resource pool to use for the VM template.
  - `vmware_datacenter` - the name of the datacenter to use for the VM template.
  - `vmware_username` - the username to use to connect to the vCenter server.
  - `vmware_insecure_connection` - whether to ignore SSL errors when connecting to the vCenter server.
  - `vmware_vm_name` - the name of the VM template. Default is `packer`. The VM template will be named like this: `"${var.vmware_vm_name}-${var.os_distr_name}-${var.os_distr_version}-${local.timestamp}"` (e.g. `packer-rocky-linux-9-20231007161411`)
  - `vmware_vm_cluster` - the name of the cluster to use for the VM template.
  - `vmware_vm_datastore` - the name of the datastore to use for the VM template.
  - `vmware_vm_version` - the VM hardware version to use for the VM template. Default is `20`.
  - `vmware_vm_destroy` - if set to true, the VM will be destroyed after the builder completes. Default is `false`.
  - `vmware_vm_network` - the name of the network to use for the VM template.
  - `vmware_vm_network_card` - the name of the network card to use for the VM template. Default is `vmxnet3`.
  - `vmware_vm_disk_controller_type` - the type of the disk controller to use for the VM template. Default is `pvscsi`.
  - `vmware_vm_disk_thin_provisioned` - whether to use thin provisioning for the VM template. Default is `true`.
  - `vmware_ssh_username` - the username to use to connect to the VM template. Default is `packer`.
  - `vmware_ssh_password` - the password to use to connect to the VM template. Default is `packer`.
  - `vmware_cl_name` - the name of the VMware Content Library to use.
  - `vmware_cl_vm_destroy` - whether to destroy the VM template after it has been uploaded to the VMware Content Library. Default is `true`.
  - `vmware_cl_ovf` - whether to upload the VM template as an OVF package. Default is `true`.
- `variables-sensitive.auto.pkrvars.hcl` - this file contains the sensitive data, such as the vCenter password, that should not be committed to the repository. This file is ignored by Git.
  - `vmware_password` - the password to use to connect to the vCenter server.
- `variables/<OS>/<OS_DISTRUBUTIVE>/<OS>-<OS_DISTRIBUTIVE>-<OS_DISTRIBUTIVE_VERSION>.pkrvars.hcl` (e.g. `variables/linux/rocky/linux-rocky-9.pkr.hcl`) - this file contains the default values for the variables used to build an OS VM template.
  - `vmware_vm_cpu` - the number of CPUs to use for the VM template.
  - `vmware_vm_cpu_cores` - the number of CPU cores to use for the VM template.
  - `vmware_vm_cpu_hot_plug` - whether to enable CPU hot plug for the VM template. Default is `true`.
  - `vmware_vm_ram` - the amount of RAM to use for the VM template.
  - `vmware_vm_ram_reserve_all` - whether to reserve all RAM for the VM template. Default is `false`.
  - `vmware_vm_ram_hot_plug` - whether to enable RAM hot plug for the VM template. Default is `true`.
  - `vmware_vm_disk_size` - the size of the disk to use for the VM template.
  - `vmware_vm_guest_os_type` - the guest OS type to use for the VM template.
  - `os_distr_version` - the version of the operating system distribution.
  - `os_distr_name` - the name of the operating system distribution.
  - `vmware_iso_url` - the URL to the ISO image of the operating system distribution.
  - `vmware_iso_url_checksum` - the checksum of the ISO image of the operating system distribution.
  - `vmware_cl_tmpl_name` - the name of the VM template in the VMware Content Library.
  - `vmware_cl_tmpl_descr` - the description of the VM template in the VMware Content Library.
- `scripts/<OS_DISTRUBUTIVE>-<OS>-<OS_DISTRIBUTIVE_VERSION>.sh` (e.g. `scripts/rocky-linux-9.sh`) - this file contains the scripts used to customize the OS VM template.
- `http/autoinstall-<OS_DISTRUBUTIVE>-<OS>-<OS_DISTRIBUTIVE_VERSION>.cfg` (e.g. `http/autoinstall-rocky-linux-9.cfg`) - this file contains the Kickstart configuration used to automate the installation of the OS VM template.

### Supported Operating Systems

This repository supports building VM templates for the following operating system:

- Rocky Linux 9
- Debian Linux 12
- Ubuntu Server 23.04

### Handling Sensitive Data

To securely pass your vCenter password to Packer, follow these steps:

1. Create a `variables-sensitive.auto.pkrvars.hcl` file in the root of your project.
2. In the file define the `vmware_password` variable, like this:

   ```hcl
   vmware_password = "your-vcenter-password"
   ```

Replace `your-vcenter-password` with your actual vCenter password.


## Build Process

Validate your configuration before building the VM template.

Example:

```shell
packer validate --var-file=variables/linux/rocky/linux-rocky-9.pkrvars.hcl .
```

Build the VM template using Packer, specifying the necessary variable files.

Example:

```shell
packer build --var-file=variables/linux/rocky/linux-rocky-9.pkrvars.hcl .
```

## Upload Process

A VM template will be automatically uploaded to a VMware Content Library after the build process is complete.
