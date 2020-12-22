{ config, pkgs, lib, ... }:
{
  powerManagement = {
    enable = true;
    powertop.enable = true;
  };

  services.tlp.enable = true;
  services.tlp.extraConfig = "
    tlp_DEFAULT_MODE=BAT
    CPU_SCALING_GOVERNOR_ON_AC=powersave
    CPU_SCALING_GOVERNOR_ON_BAT=powersave
  ";
}