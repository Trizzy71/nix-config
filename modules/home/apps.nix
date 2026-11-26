{ pkgs, ... }:

# -APPS-
# personal gui apps, on top of what desktop-apps.nix ships system-wide
{
  programs.firefox.enable = true;

  home.packages = with pkgs; [
    obsidian
    zed-editor
    spotify
    mpv # media player
    bitwarden-desktop # password manager

    # the session is wayland-only - wl-clipboard is what helix and native apps use, xclip is for xwayland
    wl-clipboard
    xclip

    # -COMMUNICATION-
    vesktop # discord
    telegram-desktop
    signal-desktop
    localsend # airdrop-style file sharing over the LAN
  ];
}
