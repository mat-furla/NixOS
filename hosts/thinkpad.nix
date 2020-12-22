{ config, lib, pkgs, ... }:
{
  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "20.09"; # Did you read the comment?


  imports =
    [
      <nixpkgs/nixos/modules/installer/scan/not-detected.nix>

      ../users/shared.nix
      ../users/manya.nix

      ../sys/aliases.nix
      # ../sys/debug.nix
      ../sys/nix.nix
      ../sys/scripts.nix
      ../sys/sysctl.nix
      ../sys/tty.nix
      ../sys/vars.nix
      ../sys/fonts.nix

      ../boot/efi.nix
      ../boot/multiboot.nix

      ../services/journald.nix
      ../services/x.nix
      ../services/postgresql.nix

      ../services/x/xmonad.nix
      ../packages/x-common.nix
      # ../packages/x-extra.nix

      ../packages/absolutely-proprietary.nix
      ../packages/common.nix
      ../packages/dev.nix
      ../packages/games.nix
      ../packages/nvim.nix
      ../packages/tmux.nix

      ../hardware/power-management.nix
      ../hardware/bluetooth.nix
      ../hardware/sound.nix
      ../hardware/mouse.nix
      ../hardware/ssd.nix

      ../services/net/firewall-desktop.nix
      ../services/net/fail2ban.nix
      ../services/net/wireguard.nix
      ../services/net/i2pd.nix
      ../services/net/tor.nix
      ../services/net/sshd.nix
      ../services/net/nginx.nix
      ../services/net/openvpn.nix

      ../services/vm/hypervisor.nix
      # ../services/vm/docker.nix
    ];

  # Boot
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

  # Network
  networking = {
    hostName = "thinkpad";
    interfaces.enp0s25.useDHCP = true;
    interfaces.wlp3s0.useDHCP = true;
    networkmanager.enable = true;
  };

  fileSystems."/" =
    {
      device = "/dev/disk/by-uuid/df8dcd09-38bd-4632-8041-8219ebdc5571";
      fsType = "ext4";
      options = [ "noatime" "nodiratime" ]; # ssd
    };

  fileSystems."/boot" =
    {
      device = "/dev/disk/by-uuid/8CCE-4F4F";
      fsType = "vfat";
      options = [ "noatime" "nodiratime" ]; # ssd
    };

  swapDevices = [];

  hardware = {
    cpu.intel.updateMicrocode = true;
  };
  services.xserver.videoDrivers = [ "intel" ];
}
