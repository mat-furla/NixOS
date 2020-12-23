{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs;
    [
      acpi
      tpacpi-bat
      powertop
    ];

  programs.light.enable = true;
}
