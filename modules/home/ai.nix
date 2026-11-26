{ pkgs, inputs, ... }:

# -AI-
# claude-code from nixpkgs-unstable so it updates faster than the 26.05 release.
let
  unstable = import inputs.nixpkgs-unstable {
    inherit (pkgs.stdenv.hostPlatform) system;
    config.allowUnfree = true; # claude-code is unfree
  };
in
{
  home.packages = [ unstable.claude-code ];
}
