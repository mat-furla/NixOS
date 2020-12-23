{ config, pkgs, lib, ... }:
{
  services.tlp = {
    enable = true;
    settings = {
      DEFAULT_MODE="BAT";

      START_CHARGE_THRESH_BAT0=45;
      STOP_CHARGE_THRESH_BAT0=80;

      CPU_SCALING_GOVERNOR_ON_AC="powersave";
      CPU_SCALING_GOVERNOR_ON_BAT="powersave";

      CPU_MIN_PERF_ON_AC=0;
      CPU_MAX_PERF_ON_AC=80;
      CPU_MIN_PERF_ON_BAT=0;
      CPU_MAX_PERF_ON_BAT=40;

      CPU_BOOST_ON_AC=0;
      CPU_BOOST_ON_BAT=0;

      SOUND_POWER_SAVE_ON_AC=1;
      SOUND_POWER_SAVE_ON_BAT=1;

      RUNTIME_PM_ON_AC="auto";
      RUNTIME_PM_ON_BAT="auto";

      NATACPI_ENABLE=1;
      TPACPI_ENABLE=1;
      TPSMAPI_ENABLE=1;
    };
  };
}
