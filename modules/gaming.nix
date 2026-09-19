{ pkgs, ... }:

{
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
    extraCompatPackages = [ pkgs.proton-ge-bin ]; # declarative Proton-GE - no mutable copy in steam
    remotePlay.openFirewall = true; # steam deck streaming
    localNetworkGameTransfers.openFirewall = true; # copy game files over LAN
    dedicatedServer.openFirewall = true;
  };

  programs.gamemode.enable = true;

  environment.systemPackages = with pkgs; [
    # various gaming launchers
    mangohud
    prismlauncher
    r2modman
    # power/thermal diag
    s-tui # live per-core stats
    lm_sensors # temps
    powertop # live c-state/power draw
  ];
}
