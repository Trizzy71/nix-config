{ ... }:

# taryn's user environment - shell and everyday apps, no dev toolchains
{
  imports = [
    ../../modules/home/shell-env.nix
    ../../modules/home/apps.nix
  ];

  home.username = "taryn";
  home.homeDirectory = "/home/taryn";
  home.stateVersion = "26.05";

  programs.home-manager.enable = true;
}
