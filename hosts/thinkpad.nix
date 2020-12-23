{ config, lib, pkgs, modulesPath, ... }:
{
  system.stateVersion = "20.09";

  imports = [
    <nixpkgs/nixos/modules/installer/scan/not-detected.nix>

    ../boot/systemd.nix

    ../hardware/intel.nix
    ../hardware/power-management.nix
    ../hardware/sound.nix
    ../hardware/ssd.nix

    ../packages/chromium.nix
    ../packages/common.nix
    ../packages/dev.nix
    ../packages/fonts.nix
    ../packages/proprietary.nix
    ../packages/thinkpad.nix

    ../services/x.nix
    ../services/bspwm.nix
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

  boot.initrd.availableKernelModules = [ "xhci_pci" "ehci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" "rtsx_pci_sdmmc" ];
  boot.initrd.kernelModules = [ "dm-snapshot" ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  boot.initrd.luks.devices = {
    crypted = {
      device = "/dev/disk/by-uuid/70382127-d3e9-4265-b012-5041a586e58c";
      preLVM = true;
      allowDiscards = true;
    };
  };

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/2b1dc5f8-9e7e-4ca9-9bb6-19e656ac1ec4";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/D646-CA7B";
    fsType = "vfat";
  };

  swapDevices = [{
    device = "/dev/disk/by-uuid/2a30e463-c302-4e9d-9b1a-faccf6581853"; 
  }];

  networking = {
    hostName = "thinkpad";
    interfaces.enp0s25.useDHCP = true;
    interfaces.wlp3s0.useDHCP = true;
    networkmanager.enable = true;
  };

  i18n.defaultLocale = "pt_BR.UTF-8";
  time.timeZone = "America/Sao_Paulo";

  users.users.matheus = {
    uid = 1000;
    isNormalUser = true;
    home = "/home/matheus";
    extraGroups = [
      "wheel" "video" "input" "networkmanager"
    ];
  };
}
