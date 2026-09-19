{ ... }:

# -EXIT NODE
# pulls ssh and tailscale
{
  imports = [
    ./ssh-system.nix
    ./tailscale-system.nix
  ];

  # fixes boot hangs - systemd wants to probe a TPM that isn't present
  systemd.tpm2.enable = false;
  boot.initrd.systemd.tpm2.enable = false;
}
