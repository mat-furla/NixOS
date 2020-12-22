{ config, pkgs, lib, ... }:
{
  vars.user = "matheus";
  vars.email = "matfurla79@gmail.com";
  vars.name = "Matheus Furlanetto";

  #home-manager = {
  #  users.manya = {
  #    xsession.windowManager.xmonad.config = lib.mkForce ./manya/xmonad.hs;
  #    home.file.".config/polybar/config".source = lib.mkForce ./manya/polybar/config;
  #  };
  #};

  #services.xserver = {
  #  displayManager = {
  #    sessionCommands = ''
  #      (rm /tmp/.xmonad-workspace-log; mkfifo /tmp/.xmonad-workspace-log) &
  #      sh ~/.fehbg
  #      xsetroot -cursor_name left_ptr

  #      lxqt-policykit-agent &
  #      xxkb &
  #      xcape -e 'Super_R=Super_R|X'
  #    '';
  #  };
  #};
}
