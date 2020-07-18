# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [
    <nixos-hardware/lenovo/thinkpad/x250> 
    ./hardware-configuration.nix 
  ];

  # Boot loader
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
  
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
    grub = {
      enable = true;
      devices = [ "nodev" ];
      efiSupport = true;
      useOSProber = true;
    };
  };

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

  # Keyboard
  i18n.defaultLocale = "pt_BR.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "br-abnt2";
  };

  # Time
  time.timeZone = "America/Sao_Paulo";
  
  # Fonts  
  fonts.fonts = with pkgs; [
    iosevka
  ];

  # Packages
  #nixpkgs.config = {
  #  allowUnfree = true;
  #  chromium = {
  #    enableWideVine = true;
  #  };
  #};

  environment.systemPackages = with pkgs; [
    bspwm               # window manager
    sxhkd		# keyboard shortcuts
    rofi                # app launcher
    rxvt-unicode        # terminal
    hsetroot            # wallpaper
    pcmanfm             # file manager
    leafpad             # text editor
    light               # backlight control
    tlp                 # power management
    chromium            # web browser
    mpv                 # media player
    cpupower
    #kotatogram-desktop  # messages
    #texlive-base        # LaTeX
    #typora              # markdown editor
    htop                # process
    git                 # version control
    #vscode              # code editor
    #nodejs              # node development
  ];

  # Sound
  sound.enable = true;
  hardware.pulseaudio.enable = true;

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

  # Xorg
  services.xserver = {
    enable = true;
    layout = "br";
    xkbModel = "abnt2";
    xkbVariant = "thinkpad";
    xkbOptions = "grp:alt_shift_toggle";
    libinput.enable = true;
    videoDrivers = [ "modesetting" ];

    deviceSection = ''
      Option     "AccelMethod" "glamor"
      Option     "DRI" "3"
    '';

    inputClassSections = [''
      Identifier   "TrackPoint"
      Driver       "libinput"
      MatchProduct "TPPS/2 IBM TrackPoint"
      Option       "AccelSpeed" "0.3"
      Option       "AccelProfile" "flat"
    ''];
    
    monitorSection = ''
      DisplaySize 276 156
    '';

    displayManager.startx.enable = true;
    displayManager.defaultSession = "none+bspwm";
    windowManager.bspwm.enable = true;
  };

  # Power Management
  #powerManagement = {
  #  enable = true;
  #  cpuFreqGovernor = "powersave";
  #};
  services.tlp.enable = true;
  services.tlp.extraConfig = "
    tlp_DEFAULT_MODE=BAT
    CPU_SCALING_GOVERNOR_ON_AC=powersave
    CPU_SCALING_GOVERNOR_ON_BAT=powersave
  ";

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

