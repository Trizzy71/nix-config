{ config, pkgs, ... }:

# Arch home.nix

{
  imports = [
    ../../modules/shell.nix
    ../../modules/git.nix
    ../../modules/dev-tools.nix
    ../../modules/neovim.nix
  ];

  home.username      = "trizzy";
  home.homeDirectory = "/home/trizzy";
  home.stateVersion  = "25.11";

  # No system profile on a standalone home-manager host; the NixOS hosts get
  # these from modules/base-system.nix.
  home.packages = with pkgs; [
    nano
    wget
  ];

  programs.zsh.shellAliases.hms = "home-manager switch --flake ~/.config/nix-config#arch";

  programs.home-manager.enable = true;
}
