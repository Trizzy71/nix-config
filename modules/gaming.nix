{ pkgs, ... }:

{
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
  };

  programs.gamemode.enable = true;
  hardware.steam-hardware.enable = true;

  environment.systemPackages = with pkgs; [
    mangohud
    protonup-qt
    prismlauncher
    gamescope
  ];
}
