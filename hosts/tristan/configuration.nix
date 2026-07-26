{ ... }:

{
  networking.hostName = "tristan";

  # Steam library on separate SSD — replace UUID after running `blkid` on the machine
  fileSystems."/mnt/games" = {
    device = "/dev/disk/by-uuid/PLACEHOLDER-UUID";
    fsType = "ext4";
    options = [
      "defaults"
      "nofail"
    ];
  };
}
