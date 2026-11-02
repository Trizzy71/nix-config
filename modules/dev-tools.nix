{ pkgs, ... }:

# -DEV TOOLS-
# cross-language tooling; per-language toolchains live in languages.nix
{
  home.packages = with pkgs; [
    claude-code # unfree; allowUnfree in base-system.nix and flake.nix
    just # command runner
  ];

  # -DIRENV-
  # auto-loads a project's env when you cd in, unloads when you cd out
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true; # caches nix shells so they don't rebuild every time
  };
}
