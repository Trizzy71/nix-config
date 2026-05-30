{ pkgs, ... }:

# -FUN PACKAGES-
{
  home.packages = with pkgs; [
    cmatrix         # makes you in the matrix
    asciiquarium    # makes the terminal a fish tank
  ];
}
