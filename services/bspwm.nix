{ config, pkgs, lib, vars, ... }:
{
  displayManager.startx.enable = true;
  displayManager.defaultSession = "none+bspwm";
  windowManager.bspwm.enable = true;
}
