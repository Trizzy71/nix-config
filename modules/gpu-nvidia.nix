{ config, pkgs, ... }:

{
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    # Hardware video decode in Firefox et al.
    extraPackages = with pkgs; [ nvidia-vaapi-driver ];
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;

    # NVIDIA's own open *kernel modules* — not nouveau. Userspace, the Vulkan
    # ICD and NVENC are still proprietary. Recommended by NVIDIA for Turing and
    # newer, and performance-identical to the closed module.
    open = true;

    package = config.boot.kernelPackages.nvidiaPackages.stable;

    # Installs the suspend/resume/hibernate units that preserve video memory.
    # Without this, waking from sleep commonly lands on a black screen.
    powerManagement.enable = true;
    # Should keep the power state locked while `ALT+TAB`
    nvidiaPersistenced = true;
  };
}
