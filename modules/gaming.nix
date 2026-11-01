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

  systemd.services.flatpak-sober = {
    description = "Install the Sober flatpak";
    wantedBy = [ "multi-user.target" ];
    wants = [ "network-online.target" ];
    after = [
      "network-online.target"
      "flatpak-flathub-remote.service"
    ];
    path = [ pkgs.flatpak ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      Restart = "on-failure";
      RestartSec = 10;
    };
    script = ''
      flatpak install --noninteractive --or-update flathub org.vinegarhq.Sober
    '';
  };
}
