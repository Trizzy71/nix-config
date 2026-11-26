{ pkgs, inputs, ... }:

# -BASE-
# every NixOS host imports this: boot, networking, locale, nix settings, home-manager
{
  imports = [ inputs.home-manager.nixosModules.home-manager ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  # cap generations to save on storage space
  boot.loader.systemd-boot.configurationLimit = 10;
  boot.tmp.cleanOnBoot = true;

  networking.networkmanager.enable = true;
  time.timeZone = "America/Chicago";

  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "us";

  services.fstrim.enable = true;
  services.fwupd.enable = true; # firmware updates
  zramSwap.enable = true;

  programs.zsh.enable = true;

  programs.nix-ld.enable = true; # lets prebuilt linux binaries run without patching

  environment.systemPackages = with pkgs; [
    git # needed to pull this repo on every machine
    nano
    wget
    pciutils # lspci - what hardware is in here
    usbutils # lsusb
  ];

  # rebuild this machine - nixos-rebuild picks the flake host matching the hostname
  environment.shellAliases.nrs = "sudo nixos-rebuild switch --flake ~/repos/nix-config";

  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nix.gc = {
    # garbage cleanup unreferenced paths
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  nix.optimise = {
    # deduplicate
    automatic = true;
    dates = [ "weekly" ];
  };

  # -HOME-MANAGER-
  # runs as part of nixos-rebuild, so system and user config switch together.
  # each host picks its user's home.nix with `home-manager.users.<name> = ./home.nix;`
  home-manager = {
    useGlobalPkgs = true; # use the same packages as system
    useUserPackages = true;
    backupFileExtension = "hm-bak"; # rename existing dotfiles instead of aborting
    extraSpecialArgs = { inherit inputs; }; # lets home modules reach flake inputs too
  };
}
