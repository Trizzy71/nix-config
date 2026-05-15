{ config, pkgs, ... }:

# Tailscale is going to need some future configuration

let
  tailscaleAPIKey = config.tailscale.apiKey or null;
in
{
  options.tailscale.apiKey = mkOption {
    type = types.str;
    description = "API key for Tailscale";
    default = null; # we can define a default here in the future
  };

  environment.systemPackages = with pkgs; [
    tailscale
  ];

  # Additional cconfig
  services.tailscale.enable = true;
  services.tailscale.apiKey = tailscaleAPIKey;

  # Tailscale up command?
  systemd.services.tailscale = {
    description = "Tailscale Service";
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.tailscale}/bin/tailscale up --authkey=${tailscaleAPIKey}";
      Restart = "always";
    };
    wantedBy = [ "multi-user.target" ];
  };
}
