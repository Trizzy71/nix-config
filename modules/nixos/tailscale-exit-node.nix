{ ... }:

# -TAILSCALE EXIT NODE-
# offers this machine as an exit node. needs tailscale.nix on the same host.
# after install, approve the exit node in the admin console.
{
  services.tailscale = {
    useRoutingFeatures = "both"; # enables IP forwarding
    # `tailscale set` runs on every boot. extraUpFlags would only apply with an authKeyFile,
    # so with a manual `tailscale up` login it never took effect
    extraSetFlags = [ "--advertise-exit-node" ];
  };
}
