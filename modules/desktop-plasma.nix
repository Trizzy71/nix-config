{ pkgs, ... }:

{
  services.desktopManager.plasma6.enable = true;

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  # PipeWire only gets the rtkit package when this is on, and plasma6 does not
  # set it. Without it PipeWire runs without realtime scheduling — audio
  # crackle under game load.
  security.rtkit.enable = true;

  # Run Electron apps (VS Code, Obsidian, Zed, vesktop) as native Wayland
  # clients instead of XWayland: correct scaling and sharper text.
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    nerd-fonts.jetbrains-mono
  ];

  services.printing.enable = true;
  services.fwupd.enable = true;

  # Without mDNS, .local hostnames do not resolve, so the NAS is only reachable
  # by whatever IP DHCP handed it. Also lets KDE Connect and Dolphin's network
  # browsing find peers. openFirewall opens UDP 5353; mDNS is link-local by
  # design, so this does not reach beyond the LAN segment.
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
}
