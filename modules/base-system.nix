{ pkgs, ... }:

{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  # Unbounded generations fill the ESP — with NVIDIA-sized initrds that
  # eventually makes every rebuild fail. Cap it.
  boot.loader.systemd-boot.configurationLimit = 10;
  boot.tmp.cleanOnBoot = true;

  networking.networkmanager.enable = true;
  time.timeZone = "America/Chicago";

  # System-wide, unlike the LANG session variable in modules/shell.nix, which
  # never reaches the display manager or system services.
  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "us";

  services.fstrim.enable = true;
  zramSwap.enable = true;

  programs.zsh.enable = true;

  environment.systemPackages = with pkgs; [
    nano
    wget
  ];

  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  # GC removes unreferenced paths; optimise deduplicates what's left.
  nix.optimise = {
    automatic = true;
    dates = [ "weekly" ];
  };

  # system.stateVersion is deliberately NOT set here. It records the release a
  # host was first installed with and must never be bumped, so it belongs to
  # the host, not to this shared module. See hosts/*/configuration.nix.
}
