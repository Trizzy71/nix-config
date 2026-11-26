{ ... }:

# tristan's user environment on exit nodes - shell, git, and a browser for the qtile session
{
  imports = [
    ../../modules/home/shell-env.nix
    ../../modules/home/git.nix
  ];

  home.username = "tristan";
  home.homeDirectory = "/home/tristan";
  home.stateVersion = "26.05";

  programs.firefox.enable = true;

  programs.home-manager.enable = true;
}
