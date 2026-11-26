{ ... }:

# -GENERIC HARDWARE-
# hand-written, not generated - lets this one config install on any x86_64 UEFI machine.
# instead of disk UUIDs it finds partitions by label, so label them when partitioning:
#   mkfs.fat -F 32 -n boot /dev/<efi-partition>
#   mkfs.ext4 -L nixos /dev/<root-partition>
# do NOT run nixos-generate-config for this host.
{
  hardware.enableAllHardware = true; # initrd carries drivers for most disks/controllers, like the installer
  hardware.enableRedistributableFirmware = true; # wifi/gpu firmware blobs
  hardware.cpu.intel.updateMicrocode = true; # only the one matching the cpu actually loads
  hardware.cpu.amd.updateMicrocode = true;

  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-label/boot";
    fsType = "vfat";
    options = [
      "fmask=0077"
      "dmask=0077"
    ];
  };

  nixpkgs.hostPlatform = "x86_64-linux";
}
