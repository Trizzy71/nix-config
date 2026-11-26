{ ... }:

# jensen - gaming + work desktop, nvidia 4070 ti super, kde plasma
{
  imports = [
    ./hardware-configuration.nix # generated on install - disks, kernel modules
    ../../modules/nixos/base.nix
    ../../modules/nixos/user-tristan.nix
    ../../modules/nixos/ssh.nix
    ../../modules/nixos/tailscale.nix
    ../../modules/nixos/plasma.nix
    ../../modules/nixos/display-manager.nix
    ../../modules/nixos/audio.nix
    ../../modules/nixos/bluetooth.nix
    ../../modules/nixos/fonts.nix
    ../../modules/nixos/lan.nix
    ../../modules/nixos/desktop-apps.nix
    ../../modules/nixos/flatpak.nix
    ../../modules/nixos/gaming.nix
    ../../modules/nixos/power.nix
    ../../modules/nixos/gpu-nvidia.nix
  ];

  networking.hostName = "jensen";

  # release defined at install - never change
  system.stateVersion = "26.05";

  # user-level config (dotfiles, user packages) lives in home.nix
  home-manager.users.tristan = ./home.nix;

  users.users.tristan.initialPassword = "y"; # im so bad

  # not hibernate-capable
  swapDevices = [
    {
      device = "/swapfile";
      size = 16 * 1024; # MiB
    }
  ];

  # steam library on separate SSD
  fileSystems."/mnt/3tb-data" = {
    device = "/dev/disk/by-uuid/1cfe5523-fbf3-42fd-bd90-9bb756e8565b";
    fsType = "xfs";
    options = [
      "defaults"
      "nofail"
    ];
  };

  systemd.tmpfiles.rules = [
    "d /mnt/3tb-data 0755 tristan users -"
  ];
}
