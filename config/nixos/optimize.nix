{ config, lib, pkgs, ... }: {
  # These optimations come from:
  # - https://github.com/NixOS/nixpkgs/pull/22310#issuecomment-644863702
  # - https://discourse.nixos.org/t/how-to-switch-cpu-governor-on-battery-power/8446/4
  environment.systemPackages = with pkgs;
    [ tlp powertop s-tui ] ++ [ config.boot.kernelPackages.cpupower ];

  powerManagement = {
    enable = true;
    powertop.enable = false;
  };

  zramSwap.enable = true;

  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_BAT="powersave";
      CPU_SCALING_GOVERNOR_ON_AC="powersave";

      # The following prevents the battery from charging fully to
      # preserve lifetime. Run `tlp fullcharge` to temporarily force
      # full charge.
      # https://linrunner.de/tlp/faq/battery.html#how-to-choose-good-battery-charge-thresholds
      START_CHARGE_THRESH_BAT0=50;
      STOP_CHARGE_THRESH_BAT0=60;

      # 100 being the maximum, limit the speed of my CPU to reduce
      # heat and increase battery usage:
      CPU_MAX_PERF_ON_AC=75;
      CPU_MAX_PERF_ON_BAT=40;
    };
  };
}
