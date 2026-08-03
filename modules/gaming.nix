{ pkgs, ... }:

{
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;

    # Declarative Proton-GE, so there is no mutable copy in ~/.steam to keep
    # track of. Shows up as a normal compatibility tool in Steam.
    extraCompatPackages = [ pkgs.proton-ge-bin ];

    # Steam calls LAN streaming "Remote Play" too — this is what lets the
    # Steam Deck stream from this machine.
    remotePlay.openFirewall = true;

    # TCP 27040: copying game files to other machines on the LAN.
    localNetworkGameTransfers.openFirewall = true;

    # TCP/UDP 27015: hosting Source dedicated servers. Host firewall only —
    # players outside the LAN also need a router port-forward.
    dedicatedServer.openFirewall = true;
  };

  programs.gamemode.enable = true;

  # hardware.steam-hardware.enable and the gamescope package both come from
  # programs.steam / gamescopeSession above.
  environment.systemPackages = with pkgs; [
    mangohud
    prismlauncher
  ];
}
