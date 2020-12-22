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

  environment.systemPackages = with pkgs;[ font-manager ];
}
