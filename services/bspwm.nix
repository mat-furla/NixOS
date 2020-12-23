{ config, pkgs, lib, ... }:
{
  services.xserver = {
    displayManager.startx.enable = true;
    displayManager.defaultSession = "none+bspwm";
    windowManager.bspwm.enable = true;
  };
}
