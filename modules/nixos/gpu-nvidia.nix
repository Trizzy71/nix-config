{ config, pkgs, ... }:

{
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [ nvidia-vaapi-driver ]; # hardware video decode in firefox
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;
    open = true; # nvidia open kernel - recommended for turing and newer
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    powerManagement.enable = true; # suspend/resume - fixes black screen waking from sleep
    nvidiaPersistenced = true; # locks power state while `ALT+TAB`
  };

  environment.systemPackages = [ pkgs.nvtopPackages.nvidia ]; # shows power states
}
