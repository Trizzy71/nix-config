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
    # The session is Wayland-only; wl-copy/wl-paste is what neovim and native
    # Wayland apps actually use. xclip stays for XWayland clients.
    wl-clipboard
    xclip
  ];
}
