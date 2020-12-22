{ pkgs, lib, ... }:
{
  services.udisks2.enable = true;
  
  services.gvfs.enable = lib.mkForce true;

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
  };
}