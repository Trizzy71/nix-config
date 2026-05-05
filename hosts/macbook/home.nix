{ config, pkgs, ... }:

# Macbook
# this file pulls these three configs into the home.nix

{
  imports = [
    ../../modules/shell.nix
    ../../modules/git.nix
    ../../modules/zig.nix
  ];

  home.username      = "tristan";
  home.homeDirectory = "/Users/tristan";
  home.stateVersion  = "25.11";

  programs.home-manager.enable = true;
}
