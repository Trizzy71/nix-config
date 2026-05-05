{ config, pkgs, ... }:

# packages required for working with zig

{
  home.packages = with pkgs; [
    zig
    zls
  ];
}
