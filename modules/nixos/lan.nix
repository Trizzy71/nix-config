{ ... }:

# -LAN-
# everything that talks to other machines on the local network
{
  services.printing.enable = true;

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  programs.kdeconnect.enable = true; # phone cursor control
  networking.firewall.allowedTCPPorts = [ 5900 ]; # krfb remote desktop control
}
