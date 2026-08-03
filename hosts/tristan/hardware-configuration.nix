{ lib, modulesPath, ... }:

# ############################################################################
# PLACEHOLDER — THIS WILL EVALUATE AND BUILD BUT WILL NOT BOOT.
#
# The UUIDs below are fake. Before installing, replace this whole file with:
#   nixos-generate-config --root /mnt --no-filesystems --show-hardware-config
# and then re-add the fileSystems entries for / and /boot from `blkid`.
#
# The generated file also brings hardware.cpu.*.updateMicrocode and the real
# boot.initrd.availableKernelModules, neither of which is here.
# ############################################################################

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = [ ];
  boot.kernelModules = [ ];
  fileSystems."/" = {
    device = "/dev/disk/by-uuid/PLACEHOLDER";
    fsType = "ext4";
  };
  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/PLACEHOLDER";
    fsType = "vfat";
  };
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
