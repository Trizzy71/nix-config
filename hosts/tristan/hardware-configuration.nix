{ lib, modulesPath, ... }:

# Placeholder — replace with output of `nixos-generate-config` on the actual machine.

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
