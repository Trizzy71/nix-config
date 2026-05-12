{ config, pkgs, ... }:

# Arch home.nix

{
  imports = [
    ../../modules/shell.nix
    ../../modules/git.nix
    ../../modules/zig.nix
  ];

  home.username      = "trizzy";
  home.homeDirectory = "/home/trizzy";
  home.stateVersion  = "25.11";

  programs.home-manager.enable = true;
}
