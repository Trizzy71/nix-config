{ pkgs, ... }:

{
  home.packages = with pkgs; [
    vesktop
    telegram-desktop
    signal-desktop
    localsend
  ];
}
