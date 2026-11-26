{ ... }:

# -AUDIO-
{
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  # pipewire needs this so that there isn't audio crackle under load
  security.rtkit.enable = true;
}
