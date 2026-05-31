{ pkgs, ... }:

# -EXIT NODE-
# shared config for all exit nodes

{
  imports = [
    ./ssh-system.nix
    ./tailscale-system.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.networkmanager.enable = true;
  time.timeZone = "America/Chicago";

  boot.blacklistedKernelModules = [
    "tpm_tis"
    "tpm_crb"
  ];

  users.users.tristan = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      tree
    ];
  };

  programs.zsh.enable = true;

  environment.systemPackages = with pkgs; [
    nano
    wget
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  system.stateVersion = "25.11";
}
