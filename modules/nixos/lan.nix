{ ... }:

# -LAN-
# everything that talks to other machines on the local network
{
  services.printing.enable = true;

  # Without mDNS, .local hostnames do not resolve, so the NAS is only reachable
  # by whatever IP DHCP handed it. Also lets KDE Connect and Dolphin's network
  # browsing find peers. openFirewall opens UDP 5353; mDNS is link-local by
  # design, so this does not reach beyond the LAN segment.
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  programs.kdeconnect.enable = true; # phone cursor control
  networking.firewall.allowedTCPPorts = [ 5900 ]; # krfb remote desktop control
}
