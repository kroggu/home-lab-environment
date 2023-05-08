# This file was autogenerated by the 'packer hcl2_upgrade' command. We
# recommend double checking that everything is correct before going forward. We
# also recommend treating this file as disposable. The HCL2 blocks in this
# file can be moved to other files. For example, the variable blocks could be
# moved to their own 'variables.pkr.hcl' file, etc. Those files need to be
# suffixed with '.pkr.hcl' to be visible to Packer. To use multiple files at
# once they also need to be in the same folder. 'packer inspect folder/'
# will describe to you what is in that folder.

# Avoid mixing go templating calls ( for example ```{{ upper(`string`) }}``` )
# and HCL2 calls (for example '${ var.string_value_example }' ). They won't be
# executed together and the outcome will be unknown.

# All generated input variables will be of 'string' type as this is how Packer JSON
# views them; you can change their type later on. Read the variables type
# constraints documentation
# https://www.packer.io/docs/templates/hcl_templates/variables#type-constraints for more info.
variable "arch" {
  type    = string
  default = "64"
}

variable "autoinst_cfg" {
  type    = string
  default = "install/autoinst.xml"
}

variable "box_basename" {
  type    = string
  default = "opensuse-leap-15.3"
}

variable "build_directory" {
  type    = string
  default = "../../builds"
}

variable "cpus" {
  type    = string
  default = "2"
}

variable "disk_size" {
  type    = string
  default = "65536"
}

variable "git_revision" {
  type    = string
  default = "__unknown_git_revision__"
}

variable "guest_additions_url" {
  type    = string
  default = ""
}

variable "headless" {
  type    = string
  default = ""
}

variable "http_proxy" {
  type    = string
  default = "${env("http_proxy")}"
}

variable "https_proxy" {
  type    = string
  default = "${env("https_proxy")}"
}

variable "iso_checksum" {
  type    = string
  default = "e377fff244d36c3a1a03092d6f14230fdae8bd116dff638a2b3a41d89d51390a"
}

variable "iso_name" {
  type    = string
  default = "openSUSE-Leap-15.3-2-DVD-x86_64-Current.iso"
}

variable "memory" {
  type    = string
  default = "1024"
}

variable "mirror" {
  type    = string
  default = "http://suse.mobile-central.org/distribution"
}

variable "mirror_directory" {
  type    = string
  default = "leap/15.3/iso"
}

variable "name" {
  type    = string
  default = "opensuse-leap-15.3"
}

variable "no_proxy" {
  type    = string
  default = "${env("no_proxy")}"
}

variable "qemu_display" {
  type    = string
  default = "none"
}

variable "template" {
  type    = string
  default = "opensuse-leap-15.3-x86_64"
}

variable "version" {
  type    = string
  default = "TIMESTAMP"
}
# The "legacy_isotime" function has been provided for backwards compatability, but we recommend switching to the timestamp and formatdate functions.

# All locals variables are generated from variables that uses expressions
# that are not allowed in HCL2 variables.
# Read the documentation for locals blocks here:
# https://www.packer.io/docs/templates/hcl_templates/blocks/locals
locals {
  build_timestamp = "${legacy_isotime("20060102150405")}"
  http_directory  = "${path.root}/http"
}

# source blocks are generated from your builders; a source can be referenced in
# build blocks. A build block runs provisioner and post-processors on a
# source. Read the documentation for source blocks here:
# https://www.packer.io/docs/templates/hcl_templates/blocks/source
source "hyperv-iso" "autogenerated_1" {
  boot_command            = ["<esc><enter><wait>", "linux ", "biosdevname=0 ", "net.ifnames=0 ", "netdevice=eth0 ", "netsetup=dhcp ", "lang=en_US ", "textmode=1 ", "autoyast=http://{{ .HTTPIP }}:{{ .HTTPPort }}/${var.autoinst_cfg}", "<enter><wait>"]
  boot_wait               = "5s"
  cpus                    = "${var.cpus}"
  disk_size               = "${var.disk_size}"
  guest_additions_path    = "VBoxGuestAdditions_{{ .Version }}.iso"
  guest_additions_url     = "${var.guest_additions_url}"
  guest_os_type           = "OpenSUSE_64"
  hard_drive_interface    = "sata"
  headless                = "${var.headless}"
  http_directory          = "${local.http_directory}"
  iso_checksum            = "${var.iso_checksum}"
  iso_url                 = "${var.mirror}/${var.mirror_directory}/${var.iso_name}"
  memory                  = "${var.memory}"
  output_directory        = "${var.build_directory}/packer-${var.template}-hyperv"
  shutdown_command        = "echo 'vagrant'|sudo -S /sbin/halt -h -p"
  ssh_password            = "vagrant"
  ssh_port                = 22
  ssh_timeout             = "10000s"
  ssh_username            = "vagrant"
  virtualbox_version_file = ".vbox_version"
  vm_name                 = "${var.template}"
}

source "parallels-iso" "autogenerated_2" {
  boot_command           = ["<esc><enter><wait>", "linux ", "biosdevname=0 ", "net.ifnames=0 ", "netdevice=eth0 ", "netsetup=dhcp ", "lang=en_US ", "textmode=1 ", "autoyast=http://{{ .HTTPIP }}:{{ .HTTPPort }}/${var.autoinst_cfg}", "<enter><wait>"]
  boot_wait              = "5s"
  cpus                   = "${var.cpus}"
  disk_size              = "${var.disk_size}"
  guest_os_type          = "opensuse"
  http_directory         = "${local.http_directory}"
  iso_checksum           = "${var.iso_checksum}"
  iso_url                = "${var.mirror}/${var.mirror_directory}/${var.iso_name}"
  memory                 = "${var.memory}"
  output_directory       = "${var.build_directory}/packer-${var.template}-parallels"
  parallels_tools_flavor = "lin"
  prlctl_version_file    = ".prlctl_version"
  shutdown_command       = "echo 'vagrant'|sudo -S /sbin/halt -h -p"
  ssh_password           = "vagrant"
  ssh_port               = 22
  ssh_timeout            = "10000s"
  ssh_username           = "vagrant"
  vm_name                = "${var.template}"
}

source "qemu" "autogenerated_3" {
  boot_command     = ["<esc><enter><wait>", "linux netsetup=dhcp netdevice=eth0 install=cd:/<wait>", " lang=en_US autoyast=http://{{ .HTTPIP }}:{{ .HTTPPort }}/${var.autoinst_cfg}<wait>", " textmode=1<wait>", "<enter><wait>"]
  boot_wait        = "5s"
  cpus             = "${var.cpus}"
  disk_size        = "${var.disk_size}"
  headless         = "${var.headless}"
  http_directory   = "${local.http_directory}"
  iso_checksum     = "${var.iso_checksum}"
  iso_url          = "${var.mirror}/${var.mirror_directory}/${var.iso_name}"
  memory           = "${var.memory}"
  output_directory = "${var.build_directory}/packer-${var.template}-qemu"
  qemuargs         = [["-m", "${var.memory}"], ["-display", "${var.qemu_display}"]]
  shutdown_command = "echo 'vagrant'|sudo -S /sbin/halt -h -p"
  ssh_password     = "vagrant"
  ssh_port         = 22
  ssh_timeout      = "10000s"
  ssh_username     = "vagrant"
  vm_name          = "${var.template}"
}

source "vmware-iso" "autogenerated_4" {
  boot_command        = ["<esc><enter><wait>", "linux ", "biosdevname=0 ", "net.ifnames=0 ", "netdevice=eth0 ", "netsetup=dhcp ", "lang=en_US ", "textmode=1 ", "autoyast=http://{{ .HTTPIP }}:{{ .HTTPPort }}/${var.autoinst_cfg}", "<enter><wait>"]
  boot_wait           = "5s"
  cpus                = "${var.cpus}"
  disk_size           = "${var.disk_size}"
  guest_os_type       = "opensuse-64"
  headless            = "${var.headless}"
  http_directory      = "${local.http_directory}"
  iso_checksum        = "${var.iso_checksum}"
  iso_url             = "${var.mirror}/${var.mirror_directory}/${var.iso_name}"
  memory              = "${var.memory}"
  output_directory    = "${var.build_directory}/packer-${var.template}-vmware"
  shutdown_command    = "echo 'vagrant'|sudo -S /sbin/shutdown -h 1"
  ssh_password        = "vagrant"
  ssh_port            = 22
  ssh_timeout         = "10000s"
  ssh_username        = "vagrant"
  tools_upload_flavor = "linux"
  vm_name             = "${var.template}"
  vmx_data = {
    "cpuid.coresPerSocket" = "1"
  }
  vmx_remove_ethernet_interfaces = true
}

# a build block invokes sources and runs provisioning steps on them. The
# documentation for build blocks can be found here:
# https://www.packer.io/docs/templates/hcl_templates/blocks/build
build {
  sources = ["source.hyperv-iso.autogenerated_1", "source.parallels-iso.autogenerated_2", "source.qemu.autogenerated_3", "source.vmware-iso.autogenerated_4"]

  provisioner "shell" {
    environment_vars  = ["HOME_DIR=/home/vagrant", "http_proxy=${var.http_proxy}", "https_proxy=${var.https_proxy}", "no_proxy=${var.no_proxy}"]
    execute_command   = "echo 'vagrant' | {{ .Vars }} sudo -S -E sh '{{ .Path }}'"
    expect_disconnect = true
    scripts           = ["${path.root}/scripts/repositories.sh", "${path.root}/scripts/update.sh", "${path.root}/../_common/motd.sh", "${path.root}/../_common/sshd.sh", "${path.root}/../_common/vagrant.sh", "${path.root}/../_common/virtualbox.sh", "${path.root}/scripts/vmware.sh", "${path.root}/../_common/parallels.sh", "${path.root}/scripts/vagrant_group.sh", "${path.root}/scripts/sudoers.sh", "${path.root}/scripts/zypper-locks.sh", "${path.root}/scripts/cleanup.sh", "${path.root}/../_common/minimize.sh"]
  }

  post-processor "vagrant" {
    output = "${var.build_directory}/${var.box_basename}.<no value>.box"
  }
}