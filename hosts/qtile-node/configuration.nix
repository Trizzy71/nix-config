{
  config,
  lib,
  pkgs,
  ...
}:

{
  networking.hostName = "qtile-node"; # Define your hostname.

  # Release this host was first installed with. Never bump.
  system.stateVersion = "26.05";

  #### X11 + WM ####
  services.xserver = {
    enable = true;
    windowManager.qtile.enable = true;
  };

  #### Programs ####
  programs.firefox.enable = true;

  #### System Profile Packages ####
  environment.systemPackages = with pkgs; [
    vim
    alacritty
  ];
}
