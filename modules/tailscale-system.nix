{ ... }:

# -TAILSCALE-
# Enables the tailscale system service and automatically sets exit node
{
  services.tailscale = {
    enable = true; # duh
    useRoutingFeatures = "both"; # enables IP forwarding
    extraUpFlags = [ "--advertise-exit-node" ]; # adds this flag to the tailscale up command
  };
}
