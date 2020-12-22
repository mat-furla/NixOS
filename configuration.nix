# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [
    <nixos-hardware/lenovo/thinkpad/x250> 
    ./hardware-configuration.nix 
  ];

  # Packages
  #nixpkgs.config = {
  #  allowUnfree = true;
  #  chromium = {
  #    enableWideVine = true;
  #  };
  #};

  # Hardware Acceleration
  nixpkgs.config.packageOverrides = pkgs: {
    vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
    chromium = pkgs.chromium.override { enableVaapi = true; };
  };
  hardware.opengl = {
    enable = true;
    driSupport = true;
    extraPackages = with pkgs; [
      vaapiIntel
      intel-media-driver
    ];
  };

  # Users
   users.users.matheus = {
    home = "/home/matheus";
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "input" "networkmanager" ];
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.03"; # Did you read the comment?
}

