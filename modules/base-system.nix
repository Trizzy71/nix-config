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

  # Overflow *below* zram, which sits at priority 5. An unset priority gets a
  # negative value from the kernel, so zram absorbs pressure first and this is
  # pure OOM insurance for a heavy rebuild with a game still running.
  #
  # Deliberately not hibernate-capable: that would need swap >= RAM plus a
  # resume_offset computed from `filefrag -v /swapfile` after the file exists,
  # and hibernate on the NVIDIA proprietary driver is unreliable. Note there is
  # no boot.resumeDevice anywhere in this config, by design.
  swapDevices = [
    {
      device = "/swapfile";
      size = 16 * 1024; # MiB
    }
  ];

  programs.zsh.enable = true;

  # On a normal distro a downloaded binary just runs. On NixOS there is no
  # /lib64/ld-linux-x86-64.so.2, so it fails with a misleading "no such file or
  # directory". This affects language servers pulled by VS Code/Zed extensions
  # and prebuilt CLI tools. The default library set covers the common cases.
  programs.nix-ld.enable = true;

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
