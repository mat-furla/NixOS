{ config, lib, pkgs, ... }:
{
  system.stateVersion = "20.09";

  imports = [
    <nixpkgs/nixos/modules/installer/scan/not-detected.nix>

    ../users/shared.nix
    ../users/thinkpad.nix

    ../sys/aliases.nix
    ../sys/fonts.nix

    ../boot/systemd.nix

    ../services/x.nix
    ../services/bspwm.nix

    ../packages/chromium.nix
    ../packages/common.nix
    ../packages/proprietary.nix

    ../hardware/intel.nix
    ../hardware/power-management.nix
    ../hardware/sound.nix
    ../hardware/ssd.nix
  ];

  boot.cleanTmpDir = lib.mkDefault true;
  boot.tmpOnTmpfs = lib.mkDefault true;
  boot.kernelParams = [
    "i915.semaphores=1"
    "i915.use_mmio_flip=1"
    "i915.powersave=1"
    "i915.enable_ips=1"
    "i915.disable_power_well=1"
    "i915.enable_hangcheck=1"
    "i915.enable_cmd_parser=1"
    "i915.fastboot=0"
    "i915.enable_ppgtt=1"
    "i915.reset=0"
    "i915.lvds_use_ssc=0"
    "i915.enable_psr=0"
    "vblank_mode=0"
    "i915.i915_enable_rc6=1"
    "quiet"
  ];
  boot.extraModprobeConfig = ''
    options iwlwifi power_save=1 power_scheme=3 bt_coex_active=0 11ndisable=1
    options snd_hda_intel power_save=1
    options snd_mia index=0
    options snd_hda_intel index=1
    blacklist sierra_net
    blacklist cdc_mbim
    blacklist cdc_ncm
    blacklist btusb
  '';

  networking = {
    hostName = "thinkpad";
    interfaces.enp0s25.useDHCP = true;
    interfaces.wlp3s0.useDHCP = true;
    networkmanager.enable = true;
  };

  #fileSystems."/" = {
  #  device = "/dev/disk/by-uuid/df8dcd09-38bd-4632-8041-8219ebdc5571";
  #  fsType = "ext4";
  #  options = [ "noatime" "nodiratime" ];
  #};
  #fileSystems."/boot" = {
  #  device = "/dev/disk/by-uuid/8CCE-4F4F";
  #  fsType = "vfat";
  #  options = [ "noatime" "nodiratime" ];
  #};
  #swapDevices = [];
}