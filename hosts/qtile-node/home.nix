{ config, pkgs, ... }:

{
  imports = [
    ../../modules/shell.nix
    ../../modules/git.nix
    ../../modules/repo-symlinks.nix
  ];

  home.username = "tristan";
  home.homeDirectory = "/home/tristan";
  home.stateVersion = "26.05";

  programs.zsh.shellAliases.nrs = "sudo nixos-rebuild switch --flake ~/.config/nix-config#qtile-node";

  programs.home-manager.enable = true;
}
