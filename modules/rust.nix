{ config, pkgs, ... }:

# Rust dev environment

{
  home.packages = with pkgs; [
    rustup
    rust-analyzer
    cargo-expand
    cargo-watch
    cargo-edit
    cargo-outdated
    cargo-audit
  ];
}
