{ config, ... }:

{
  imports = [
    ../../modules/shell.nix
    ../../modules/git.nix
    ../../modules/dev-tools.nix
    ../../modules/languages.nix
    ../../modules/desktop-apps.nix
    ../../modules/daily-tools.nix
    ../../modules/communication.nix
    ../../modules/ai.nix
  ];

  home.username = "tristan";
  home.homeDirectory = "/home/tristan";
  home.stateVersion = "26.05";

  # convenience handle on the WoW: Forever AddOns dir inside the Proton prefix.
  # out-of-store symlink - the target is mutable game state, so nix points at it
  # rather than copying it into the store.
  home.file."wow-forever-addons".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.local/share/Steam/steamapps/compatdata/2960081357/pfx/drive_c/Program Files (x86)/World of Warcraft/_forever_/Interface/AddOns";

  # home-manager runs as a NixOS module here, so `home-manager switch` does not
  # apply — the whole system rebuilds as one unit.
  programs.zsh.shellAliases.nrs = "sudo nixos-rebuild switch --flake ~/repos/nix-config#tristan";

  programs.home-manager.enable = true;
}
