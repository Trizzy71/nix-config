{ pkgs, ... }:

# Just fun test packages
{
  home.packages = with pkgs; [
    cmatrix
    asciiquarium
  ];
}
