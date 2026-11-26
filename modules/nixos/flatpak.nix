{ pkgs, ... }:

# -FLATPAK-
# Escape hatch for anything not worth packaging in nix, and for apps whose
# nixpkgs version lags the release branch. Deliberately a *second* place
# software can come from: `flatpak update` is its own update path, separate
# from nixos-rebuild.
#
# services.flatpak already handles the fiddly parts for us:
#   - fonts.fontDir.enable, so flatpak apps can see host fonts
#   - environment.profiles += the exports dirs, so their .desktop entries
#     show up in the Plasma launcher
#   - polkit, dbus, systemd units and tmpfiles
# It asserts xdg.portal.enable, which plasma6 turns on.
{
  services.flatpak.enable = true;

  # The module does not register any remote, which would leave `flatpak
  # install` with nowhere to install from. Add Flathub declaratively so the
  # machine is usable without remembering the remote-add incantation.
  systemd.services.flatpak-flathub-remote = {
    description = "Register the Flathub remote for Flatpak";
    wantedBy = [ "multi-user.target" ];
    wants = [ "network-online.target" ];
    after = [
      "network-online.target"
      "flatpak-system-helper.service"
    ];
    path = [ pkgs.flatpak ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      # Needs the network; retry rather than leaving the box with no remote
      # if this races DHCP on a cold boot.
      Restart = "on-failure";
      RestartSec = 10;
    };
    # --if-not-exists makes this idempotent across rebuilds and reboots.
    script = ''
      flatpak remote-add --if-not-exists flathub \
        https://flathub.org/repo/flathub.flatpakrepo
    '';
  };
}
