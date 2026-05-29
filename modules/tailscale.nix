{ config, pkgs, ... }:

# -TAILSCALE-
{
  home.packages = with pkgs; [
    tailscale
  ];

}
