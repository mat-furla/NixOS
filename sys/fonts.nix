{ pkgs, lib, ... }:
{
  fonts = {
    enableDefaultFonts = true;
    fontDir.enable = true; # ls /run/current-system/sw/share/X11-fonts
    fontconfig = {
      enable = true;
      hinting.enable = true;
      antialias = true;
      defaultFonts = {
        monospace = [ "Iosevka" ];
        sansSerif = [ "Roboto" ];
        serif = [ "Roboto Slab" ];
      };
    };

    fonts = with pkgs;
      [
        noto-fonts
        noto-fonts-emoji
        corefonts
        (nerdfonts.override { fonts = [ "Iosevka" ]; })
        roboto
        roboto-slab
        roboto-mono
      ];
  };

  i18n.defaultLocale = "pt_BR.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "br-abnt2";
  };

  environment.systemPackages = with pkgs;[ font-manager ];
}
