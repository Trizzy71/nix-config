{ ... }:

# -DISPLAY MANAGER-
# the login screen. stays the same when the desktop changes.
{
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  # run electron apps native on wayland instead of xwayland
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
