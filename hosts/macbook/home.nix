{ config, pkgs, ... }:

# Macbook
# this file pulls these three configs into the home.nix

{
  imports = [
    ../../modules/shell.nix
    ../../modules/neovim.nix
    ../../modules/git.nix
    ../../modules/zig.nix
  ];

  home.username      = "tristan";
  home.homeDirectory = "/Users/tristan";
  home.stateVersion  = "25.11";

  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  programs.home-manager.enable = true;
}
