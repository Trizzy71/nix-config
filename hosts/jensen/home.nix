{ ... }:

# tristan's user environment on jensen
{
  imports = [
    ../../modules/home/shell-env.nix
    ../../modules/home/git.nix
    ../../modules/home/dev.nix
    ../../modules/home/ai.nix
    ../../modules/home/apps.nix
  ];

  home.username = "tristan";
  home.homeDirectory = "/home/tristan";
  home.stateVersion = "26.05";

  programs.home-manager.enable = true;
}
