{ pkgs, ... }:

# Macbook
# standalone home-manager - shell/cli/dev tools from nix, gui apps from .dmg and the app store

{
  imports = [
    ../../modules/home/shell-env.nix
    ../../modules/home/git.nix
    ../../modules/home/dev.nix
    ../../modules/home/ai.nix
  ];

  home.username = "tristan";
  home.homeDirectory = "/Users/tristan";
  home.stateVersion = "25.11";

  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    # no system profile on a standalone home-manager host; the NixOS hosts get
    # these from modules/nixos/base.nix
    nano
    wget
  ];

  programs.zsh.shellAliases.hms = "home-manager switch --flake ~/repos/nix-config#macbook -b hm-bak"; # -b: move colliding files aside instead of aborting

  programs.zsh.initContent = ''
    eval "$(/opt/homebrew/bin/brew shellenv zsh)"

    if [ -e /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]; then
      . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
    fi
  '';

  programs.home-manager.enable = true;
}
