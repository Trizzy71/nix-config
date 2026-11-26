{ pkgs, ... }:

# -APPS-
# personal gui apps, on top of what desktop-suite.nix ships system-wide
{
  programs.firefox.enable = true;

  home.packages = with pkgs; [
    obsidian
    zed-editor
    spotify

    # -COMMUNICATION-
    vesktop # discord
    telegram-desktop
    signal-desktop
    localsend # airdrop-style file sharing over the LAN
  ];
}
