{ ... }:

let
  mkDiskSpaceModule = path: position: {
    "disk ${path}" = {
      inherit position;
      settings = {
        # only display something if below threshold:
        format = "";
        format_below_threshold = "${path} %percentage_avail";
        low_threshold = 25;
      };
    };
  };
  diskSpaceModules = mkDiskSpaceModule "/" 5;
in
{
  config = {
    programs.i3status = {
      enable = true;
      enableDefault = false;

      general = {
        colors = true;
        interval = 5;
      };

      modules = {
        "read_file mpd" = {
          position = 2;
          settings = {
            format = "%content";
            format_bad = "";
            path = "/tmp/i3status-current-song.log";
          };
        };

        "volume master" = {
          position = 4;
          settings = {
            format = "♪ %volume";
            format_muted = "♪ muted";
            device = "default";
            mixer = "Master";
          };
        };

        "battery 0" = {
          position = 7;
          settings = {
            format = "%status %remaining";
            hide_seconds = true;
            last_full_capacity = true;
            low_threshold = 30;
            threshold_type = "time";
            integer_battery_capacity = true;
          };
        };

        "load" = {
          position = 8;
          settings = {
            # only display something if above threshold:
            format = "";
            format_above_threshold = "%1min";
            max_threshold = "5";
          };
        };

        "tztime local" = {
          position = 17;
          settings = {
            format = "%a %d %b — %H:%M";
          };
        };
      } // diskSpaceModules;
    };
  };
}
