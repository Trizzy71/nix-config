{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    # Import hardware-configuration.nix
    # This is defined in flake.nix right now
    # Shared NixOS baseline (boot loader, networkmanager, timezone, user,
    # zsh, stateVersion) comes from modules/base-system.nix; tailscale +
    # ssh come from modules/exit-node.nix. Both are wired in flake.nix.
  ];

  networking.hostName = "dell"; # Define your hostname.

  # Release this host was first installed with. Never bump.
  system.stateVersion = "25.11";

  # boot.kernel.sysctl."net.core.rmem_max" = 2500000; # this is for higher ts throughput

  #### Internationalisation ####
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  #### X11 + WM ####
  # services.xserver.enable = true;
  services.xserver = {
    enable = true;
    windowManager.qtile.enable = true;
  };

  #### Keymap ####
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  #### Printing ####
  # services.printing.enable = true;

  #### Sound ####
  # services.pulseaudio.enable = true;
  # OR
  # services.pipewire = {
  #   enable = true;
  #   pulse.enable = true;
  # };

  #### Touchpad support (enabled default in most desktopManager) ####
  # services.libinput.enable = true;

  #### Programs ####
  programs.firefox.enable = true;

  #### System Profile Packages ####
  environment.systemPackages = with pkgs; [
    vim
    # wget     # DONT TOUCH
    alacritty
  ];
}
