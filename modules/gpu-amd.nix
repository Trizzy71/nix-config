{ pkgs, ... }:

{
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      vulkan-loader
    ];
  };

  environment.systemPackages = [ pkgs.nvtopPackages.amd ]; # shows power states
}
