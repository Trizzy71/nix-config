{ pkgs, ... }:

# -DESKTOP APP SUITE-
# roughly matches what KDE ships with

{
  programs.kdeconnect.enable = true; # phone cursor control
  networking.firewall.allowedTCPPorts = [ 5900 ]; # krfb remote desktop control

  environment.systemPackages =
    with pkgs;
    [
      # -OFFICE-
      libreoffice-qt6-still # stable release line

      # -CREATIVE- KDE defaults
      krita # digital painting
      digikam # photo management
      haruna # KDE's mpv-based video player
      subtitlecomposer # subtitle editing/syncing for kdenlive
      kid3 # audio tagger
      krename # batch rename

      # -DEV-
      gdb # debugger
      heaptrack # heap profiler
      okteta # hex editor
    ]
    ++ (with pkgs.kdePackages; [
      kdenlive # video editor
      glaxnimate # vector animation, integrates with kdenlive
      kwave # audio editor

      # -UTILITIES- KDE defaults
      kcalc # calculator
      kfind # file search
      filelight # disk usage, radial view
      kolourpaint # simple raster editing
      kcharselect # unicode picker
      kcolorchooser # colour picker
      partitionmanager # disk partitioning
      kompare # visual diff
      yakuake # drop-down terminal on F12
      isoimagewriter # write an ISO to USB — used to build the installer stick
      ksystemlog # GUI journal reader

      # -REMOTE DESKTOP- KDE defaults
      krfb # share this screen (VNC)
      krdc # connect to another machine (VNC/RDP) - needs no open port

      # -GAMES-
      kpat # solitaire
      ksudoku
      kmines # minesweeper
      kbreakout # breakout
      kblocks # falling blocks
      kolf # mini golf
      granatier # bomberman
      palapeli # jigsaw puzzles
      picmi # nonogram
      bomber
      knights # chess
      kigo # go
    ]);
}
