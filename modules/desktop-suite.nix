{ pkgs, ... }:

# -DESKTOP APP SUITE-
# Rounds the bare Plasma install out into a full-featured desktop, roughly
# matching what Fedora KDE ships plus the apps KDE leads with on kde.org.
#
# Already provided by services.desktopManager.plasma6 — do NOT add these here:
#   ark, discover, dolphin, elisa, gwenview, kate, kinfocenter, konsole,
#   okular (PDF viewer), plasma-systemmonitor, spectacle, kwalletmanager
{
  # Phone/desktop integration. Uses the NixOS module rather than the bare
  # package so the pairing and file-transfer ports get opened for us.
  programs.kdeconnect.enable = true;

  # krfb is a VNC server. Without this it is only reachable on localhost, so
  # the whole point of it — helping on the other desktop — would not work.
  # It listens only while a sharing session is actively running, and gates
  # connections behind its own password/confirmation settings.
  # 5900 is the VNC default; confirm against krfb's settings after install.
  networking.firewall.allowedTCPPorts = [ 5900 ];

  environment.systemPackages =
    with pkgs;
    [
      # -OFFICE-
      # The "still" branch, not "fresh": it is LibreOffice's conservative
      # release line. qt6 so it picks up Breeze instead of looking like a
      # GTK app dropped into Plasma.
      libreoffice-qt6-still

      # -CREATIVE- (the apps KDE showcases)
      krita # digital painting
      digikam # photo management
      haruna # KDE's mpv-based video player
      subtitlecomposer # subtitle editing/syncing, pairs with kdenlive
      kid3 # audio tagger, tidies the Elisa library
      krename # batch rename from EXIF/ID3, pairs with digikam

      # -DEV-
      # These live here rather than in modules/dev-tools.nix on purpose: that
      # module is home-manager level and is imported by macbook (darwin) and
      # arch too, and heaptrack is Linux-only.
      gdb # debugger — step through a program, inspect state
      heaptrack # heap profiler; self-contained, unlike the valgrind frontends
      okteta # hex editor
    ]
    ++ (with pkgs.kdePackages; [
      kdenlive # video editor
      glaxnimate # vector animation, integrates with kdenlive
      kwave # audio editor

      # -UTILITIES- (Fedora KDE's default set)
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
      ksystemlog # GUI journal reader, for when a rebuild breaks the desktop

      # -REMOTE DESKTOP-
      krfb # share this screen (VNC) — see the firewall port above
      krdc # connect to another machine (VNC/RDP); needs no open port

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
