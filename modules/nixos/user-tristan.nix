{ pkgs, ... }:

{
  users.users.tristan = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      tree
    ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDZVLStwmxT0sVSFSt745kD9XbW0NFrxUxWPDOpdsdIQ tristan.m.peterson@gmail.com"
    ];
  };
}
