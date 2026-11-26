{ ... }:

# -TAILSCALE EXIT NODE-
# joins the tailnet and offers this machine as an exit node.
# after install, run `sudo tailscale up` once and approve the exit node in the admin console.
{
  services.tailscale = {
    enable = true;
    useRoutingFeatures = "both"; # enables IP forwarding
    # `tailscale set` runs on every boot. extraUpFlags would only apply with an authKeyFile,
    # so with a manual `tailscale up` login it never took effect
    extraSetFlags = [ "--advertise-exit-node" ];
  };
}
