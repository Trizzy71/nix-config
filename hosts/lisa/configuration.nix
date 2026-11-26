{ ... }:

# lisa - taryn's gaming desktop, amd rx 480, kde plasma. kept minimal on purpose
{
  imports = [
    ./hardware-configuration.nix # generated on install - disks, kernel modules
    ../../modules/nixos/base.nix
    ../../modules/nixos/user-taryn.nix
    ../../modules/nixos/desktop.nix
    ../../modules/nixos/desktop-suite.nix
    ../../modules/nixos/flatpak.nix
    ../../modules/nixos/gaming.nix
    ../../modules/nixos/gpu-amd.nix
  ];

  networking.hostName = "lisa";

  # release defined at install - never change
  system.stateVersion = "26.05";

  # user-level config (dotfiles, user packages) lives in home.nix
  home-manager.users.taryn = ./home.nix;

  # not hibernate-capable
  swapDevices = [
    {
      device = "/swapfile";
      size = 16 * 1024; # MiB
    }
  ];
}
