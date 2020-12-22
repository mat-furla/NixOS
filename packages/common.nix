{ config, pkgs, lib, ... }:
let
  stable = import <stable> {
    config = config.nixpkgs.config;
  };
in
{
  environment = {
    variables = {
      VISUAL = "nano";
      BROWSER = "chromium";
      TERMINAL = "alacritty";
    };

    etc."xdg/gtk-3.0/settings.ini" = {
      text = ''
        [Settings]
        gtk-theme-name=Dracula
      '';
    };

    # run xfce4-mime-settings to change with gui
    etc."xdg/mimeapps.list" = {
      text = ''
        [Default Applications]
        application/javascript=leafpad.desktop;
        application/json=leafpad.desktop;
        text/plain=leafpad.desktop;
        inode/directory=spacefm.desktop
        x-scheme-handler/http=chromium.desktop
        x-scheme-handler/https=chromium.desktop
        x-scheme-handler/ftp=chromium.desktop
        x-scheme-handler/chrome=chromium.desktop
        text/html=chromium.desktop
        application/x-extension-htm=chromium.desktop
        application/x-extension-html=chromium.desktop
        application/x-extension-shtml=chromium.desktop
        application/xhtml+xml=chromium.desktop
        application/x-extension-xhtml=chromium.desktop
        application/x-extension-xht=chromium.desktop
        x-scheme-handler/magnet=userapp-transmission-gtk-DXP9G0.desktop
        x-scheme-handler/about=chromium.desktop
        x-scheme-handler/unknown=chromium.desktop
        video/x-matroska=mpv.desktop;
        video/mpeg=mpv.desktop;
        image/gif=nomacs.desktop;
        image/png=nomacs.desktop;
        image/jpeg=nomacs.desktop;imv.desktop;
        image/jpeg=nomacs.desktop;imv.desktop;
        image/png=nomacs.desktop;imv.desktop;

        [Added Associations]
        application/javascript=leafpad.desktop;
        application/json=leafpad.desktop;
        text/markdown=leafpad.desktop;
        text/plain=leafpad.desktop;
        x-scheme-handler/http=chromium.desktop;
        x-scheme-handler/https=chromium.desktop;
        x-scheme-handler/ftp=chromium.desktop;
        x-scheme-handler/chrome=chromium.desktop;
        text/html=chromium.desktop;
        application/x-extension-htm=chromium.desktop;
        application/x-extension-html=chromium.desktop;
        application/x-extension-shtml=chromium.desktop;
        application/xhtml+xml=chromium.desktop;
        application/x-extension-xhtml=chromium.desktop;
        application/x-extension-xht=chromium.desktop;

        application/pdf=zathura.desktop;
        video/x-matroska=mpv.desktop;
        video/mpeg=mpv.desktop;     
      '';
    };
  };

  console.useXkbConfig = true;

  environment.systemPackages = with pkgs;
    [
      alacritty           # terminal
      chromium            # web browser
      rofi                # app launcher
      hsetroot            # wallpaper
      mpv                 # media player
      zathura             # pdf viewer
      leafpad             # text editor
      libreoffice-fresh   # text editor
      dracula-theme       # gtk theme
      libnotify           # notifications
      dunst               # notifications
    ];
}
