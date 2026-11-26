{ ... }:

# -TAILSCALE-
# joins the tailnet. after install, run `sudo tailscale up` once.
{
  services.tailscale.enable = true;
}
