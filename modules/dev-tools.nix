{ pkgs, ... }:

# -DEV TOOLS-
{
  home.packages = with pkgs; [
    rustup          # the rust programming language
    cargo-expand    # a collection of rust tools
    cargo-watch
    cargo-edit
    cargo-outdated
    cargo-audit
    zig   # the zig programming language
    zls
    nil
    nixd  # the nix programming lanugage
  ];
}
