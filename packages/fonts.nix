{ pkgs, lib, ... }:
{
  fonts = {
    enableDefaultFonts = true;
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
  
  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true;
  };
}
