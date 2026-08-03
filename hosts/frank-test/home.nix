{ config, pkgs, ... }:

# frank-test linux machine config

{
  imports = [
    ../../modules/shell.nix
    ../../modules/git.nix
    ../../modules/neovim.nix
  ];

  home.username = "tristan";
  home.homeDirectory = "/home/tristan";
  home.stateVersion = "25.11";

  programs.zsh.shellAliases.nrs = "sudo nixos-rebuild switch --flake ~/.config/nix-config#frank-test";

  programs.home-manager.enable = true;
}
