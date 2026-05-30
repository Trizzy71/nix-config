{ ... }:

# -TAILSCALE-
# Enables the tailscale system service and automatically sets exit node
# Still don't know whether or not they all need to be exit nodes
{
  services.tailscale = {
    enable = true;
    useRoutingFeatures = "both"; # enables IP forwarding
    extraUpFlags = [ "--advertise-exit-node" ]; # adds this flag to the tailscale up command
  };
}
