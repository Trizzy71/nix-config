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
    ]
    ++ (with pkgs.kdePackages; [
      kdenlive # video editor

      # -UTILITIES- (Fedora KDE's default set)
      kcalc # calculator
      kfind # file search
      filelight # disk usage, radial view
      kolourpaint # simple raster editing
      kcharselect # unicode picker
      kcolorchooser # colour picker
      partitionmanager # disk partitioning
      kompare # visual diff

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
