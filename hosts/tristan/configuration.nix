{ ... }:

{
  networking.hostName = "tristan";

  # Release this host was first installed with. Never bump.
  system.stateVersion = "26.05";

  # Set at account creation only; change with `passwd` after first boot.
  # Gates sudo and the SDDM unlock, so it is a local-console password.
  # Not remotely exposed: modules/ssh-system.nix is key-only.
  users.users.tristan.initialPassword = "y";

  # Steam library on separate SSD — replace UUID after running `blkid` on the machine
  fileSystems."/mnt/3tb-data" = {
    device = "/dev/disk/by-uuid/1cfe5523-fbf3-42fd-bd90-9bb756e8565b";
    fsType = "xfs";
    options = [
      "defaults"
      "nofail"
    ];
  };

  # A freshly formatted ext4 mount is root-owned; Steam needs to write to it.
  systemd.tmpfiles.rules = [
    "d /mnt/3tb-data 0755 tristan users -"
  ];
}
