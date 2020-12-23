{
  nixpkgs.config = {
    chromium = {
      enableWideVine = true;
    };
  };

  nixpkgs.config.packageOverrides = pkgs: {
    vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
    chromium = pkgs.chromium.override { enableVaapi = true; };
  };
}