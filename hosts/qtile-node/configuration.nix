{ pkgs, ... }:

# qtile-node - tailscale exit node with a bare qtile session.
# generic on purpose: the same config installs on any x86_64 UEFI box (see hardware-generic.nix)
{
  imports = [
    ./hardware-generic.nix # partitions by label, drivers for most hardware
    ../../modules/nixos/base.nix
    ../../modules/nixos/user-tristan.nix
    ../../modules/nixos/ssh.nix
    ../../modules/nixos/tailscale-exit-node.nix
  ];

  networking.hostName = "qtile-node";

  # release this host was first installed with - never change
  system.stateVersion = "26.05";

  # user-level config (dotfiles, user packages) lives in home.nix
  home-manager.users.tristan = ./home.nix;

  # fixes boot hangs on machines without a TPM - systemd waits on a probe that never answers
  systemd.tpm2.enable = false;
  boot.initrd.systemd.tpm2.enable = false;

  #### X11 + WM ####
  services.xserver = {
    enable = true;
    windowManager.qtile.enable = true;
  };

  programs.firefox.enable = true;

  environment.systemPackages = with pkgs; [
    vim
    alacritty
  ];
}
