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
  home.stateVersion = "25.11";
  programs.home-manager.enable = true;
}
