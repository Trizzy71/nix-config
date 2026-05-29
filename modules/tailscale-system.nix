{ ... }:
{
  services.tailscale = {
    enable = true;
    useRoutingFeatures = "both"; # enables IP forwarding
    extraUpFlags = [ "--advertise-exit-node" ]; # adds this flag to the tailscale up command
  };
}
