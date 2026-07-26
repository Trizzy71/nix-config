{ pkgs, ... }:

{
  home.packages = with pkgs; [
    ripgrep
    fd
    unzip
    p7zip
    jq
    ncdu
    duf
    curl
    rsync
    pciutils
    usbutils
    mpv
    xclip
  ];
}
