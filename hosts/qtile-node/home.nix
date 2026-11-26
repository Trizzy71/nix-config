{ ... }:

# tristan's user environment on exit nodes - shell and git only
{
  imports = [
    ../../modules/home/shell.nix
    ../../modules/home/git.nix
  ];

  home.username = "tristan";
  home.homeDirectory = "/home/tristan";
  home.stateVersion = "26.05";

  programs.home-manager.enable = true;
}
