{ pkgs, pkgs-unstable, ... }:

# -DEV TOOLS-
# cross-language tooling; per-language toolchains live in languages.nix
{
  home.packages = with pkgs; [
    just # command runner
  ] ++ [
    pkgs-unstable.claude-code # unfree; allowUnfree in base-system.nix and flake.nix. pulled from unstable so it updates faster than nixos-26.05
  ];

  # -DIRENV-
  # auto-loads a project's env when you cd in, unloads when you cd out
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true; # caches nix shells so they don't rebuild every time
  };
}
