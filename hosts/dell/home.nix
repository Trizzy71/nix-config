{ config, pkgs, ... }:

# Dell linux machine config

{
  imports = [
    ../../modules/shell.nix
    ../../modules/git.nix
    ../../modules/neovim.nix
    ../../modules/tailscale.nix
  ];

  home.username = "tristan";
  home.homeDirectory = "/home/tristan";
  home.stateVersion = "25.11";

  programs.home-manager.enable = true;
}
