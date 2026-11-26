{ pkgs, ... }:

# -POWER + MONITORING-
# cpu governor, and the tools to watch power, heat, and gpu load
{
  powerManagement.cpuFreqGovernor = "performance";

  environment.systemPackages = with pkgs; [
    nvtopPackages.full # gpu load and power, nvidia and amd
    s-tui # live per-core stats
    lm_sensors # temps
    powertop # live c-state/power draw
  ];
}
