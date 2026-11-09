{ pkgs, ... }:

{
  # nixpkgs 26.05 ships instawow 7.0.0.post1, which predates WoW: Forever support -
  # the `_forever_` flavour landed upstream in 7.2.0. Bump to the current release.
  nixpkgs.overlays = [
    (
      _final: prev:
      let
        # 7.2.0+ needs click >= 8.4.1 for a generic it subscripts at import time;
        # 26.05 has 8.3.1, which breaks the CLI outright. Scoped to instawow only.
        python = prev.python3.override {
          packageOverrides = _pyFinal: pyPrev: {
            click = pyPrev.click.overridePythonAttrs (_: rec {
              version = "8.4.2";
              src = pyPrev.fetchPypi {
                pname = "click";
                inherit version;
                hash = "sha256-mmzqbmCxfr4KRMXMY22U8JvWYULBzX2LTNcxxJF6FfY=";
              };
            });
          };
        };
      in
      {
        instawow = (prev.instawow.override { python3 = python; }).overrideAttrs (old: rec {
          version = "7.3.0";
          # sdist, not the git tag - 7.3.0 builds its version with versioningit,
          # which needs the PKG-INFO that only the sdist carries.
          src = python.pkgs.fetchPypi {
            pname = "instawow";
            inherit version;
            hash = "sha256-ZB+FuMf5oJVRAtsinhFa6NQH5FvInpfnTlchsrVbgA8=";
          };
          nativeBuildInputs = old.nativeBuildInputs ++ [ python.pkgs.versioningit ];
          propagatedBuildInputs = old.propagatedBuildInputs ++ [ python.pkgs.wcwidth ]; # new dep in 7.x
          pythonRelaxDeps = [
            "aiohttp"
            "rapidfuzz"
            "yarl"
          ]; # upstream pins to latest-at-release; the APIs used are stable
        });
      }
    )
  ];

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
    instawow # wow addon manager - auto-detects the _forever_ flavour
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
