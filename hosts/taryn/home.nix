{ ... }:

{
  imports = [
    ../../modules/shell.nix
    ../../modules/neovim.nix
    ../../modules/git.nix
    ../../modules/dev-tools.nix
    ../../modules/desktop-apps.nix
    ../../modules/daily-tools.nix
  ];

  home.username = "taryn";
  home.homeDirectory = "/home/taryn";
  home.stateVersion = "26.05";

  # home-manager runs as a NixOS module here, so `home-manager switch` does not
  # apply — the whole system rebuilds as one unit.
  programs.zsh.shellAliases.nrs = "sudo nixos-rebuild switch --flake ~/.config/nix-config#taryn";

  programs.home-manager.enable = true;
}
