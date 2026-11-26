{ ... }:

# tristan's user environment on jensen
{
  imports = [
    ../../modules/home/shell.nix
    ../../modules/home/git.nix
    ../../modules/home/dev.nix
    ../../modules/home/apps.nix
    ../../modules/home/daily-tools.nix
  ];

  home.username = "tristan";
  home.homeDirectory = "/home/tristan";
  home.stateVersion = "26.05";

  programs.home-manager.enable = true;
}
