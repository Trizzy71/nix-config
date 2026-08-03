{ config, pkgs, ... }:

# Macbook
# this file pulls these four .nix files into home-manager

{
  imports = [
    ../../modules/shell.nix
    ../../modules/neovim.nix
    ../../modules/git.nix
    ../../modules/dev-tools.nix
  ];

  home.username = "tristan";
  home.homeDirectory = "/Users/tristan";
  home.stateVersion = "25.11";

  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    # No system profile on a standalone home-manager host; the NixOS hosts get
    # these from modules/base-system.nix.
    nano
    wget
  ];

  programs.zsh.shellAliases.hms = "home-manager switch --flake ~/.config/nix-config#macbook";

  programs.zsh.initContent = ''
    eval "$(/opt/homebrew/bin/brew shellenv zsh)"

    if [ -e /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]; then
      . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
    fi
  '';

  programs.home-manager.enable = true;
}
