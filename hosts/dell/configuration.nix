
{ config, lib, pkgs, ... }:

{
  imports =
    [ # Import hardware-configuration.nix
      ./hardware-configuration.nix
    ];

  # Systemd + EFI boot #
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos-test"; # Define your hostname.

  #### Networking (nmcli | nmtui) ####
  networking.networkmanager.enable = true;

  #### Time Zone ####
  time.timeZone = "America/Chicago";

  #### Internationalisation ####
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  #### X11 + WM ####
  # services.xserver.enable = true;
  services.xserver = {
    enable = true;
    windowManager.qtile.enable = true;
  };

  

  #### Keymap ####
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  #### Printing ####
  # services.printing.enable = true;

  #### Sound ####
  # services.pulseaudio.enable = true;
  # OR
  # services.pipewire = {
  #   enable = true;
  #   pulse.enable = true;
  # };

  #### Touchpad support (enabled default in most desktopManager) ####
  # services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.tristan = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkManager" ]; # Enable ‘sudo’ for the user.
    shell       = pkgs.zsh;
    packages = with pkgs; [
      tree
    ];
  };

  #### Programs ####
  programs.firefox.enable = true;
  programs.zsh.enable = true;

  #### System Profile Packages ####
  environment.systemPackages = with pkgs; [
    vim        #
    # wget     # DONT TOUCH
    alacritty  #
  ];

  #### System state and Experimental features ####
  system.stateVersion = "25.11";
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

}

