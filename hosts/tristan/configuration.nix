{ ... }:

{
  networking.hostName = "tristan";

  # release defined at install - never change
  system.stateVersion = "26.05";

  users.users.tristan.initialPassword = "y"; # im so bad

  # steam library on separate SSD
  fileSystems."/mnt/3tb-data" = {
    device = "/dev/disk/by-uuid/1cfe5523-fbf3-42fd-bd90-9bb756e8565b";
    fsType = "xfs";
    options = [
      "defaults"
      "nofail"
    ];
  };

  systemd.tmpfiles.rules = [
    "d /mnt/3tb-data 0755 tristan users -"
  ];
}
