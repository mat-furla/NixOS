{ config, pkgs, lib, ... }:
{
  displayManager.startx.enable = true;
  displayManager.defaultSession = "none+bspwm";
  windowManager.bspwm.enable = true;
}