{ pkgs, ... }:

{
  programs.firefox.enable = true;

  home.packages = with pkgs; [
    obsidian
    zed-editor
    spotify
  ];
}
