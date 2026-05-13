{ config, pkgs, ... }:

# All of my developer tools
# Rust, Zig, LS deps

{
  home.packages = with pkgs; [
    rustup
    cargo-expand
    cargo-watch
    cargo-edit
    cargo-outdated
    cargo-audit
    zig
    zls
    nil
    nixd
  ];
}
