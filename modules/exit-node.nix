{ ... }:

# -EXIT NODE-
# Additional config for hosts acting as tailscale exit nodes with remote
# SSH management. Import alongside modules/base-system.nix, not instead
# of it.

{
  imports = [
    ./ssh-system.nix
    ./tailscale-system.nix
  ];

  # Works around long boot hangs from systemd probing a TPM that isn't
  # present (seen on test VMs with no TPM device).
  systemd.tpm2.enable = false;
  boot.initrd.systemd.tpm2.enable = false;
}
