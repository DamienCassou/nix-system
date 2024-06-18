_:

{
  programs.waybar = {
    enable = true;
    systemd = {
      enable = true;
      target = "sway-session.target";
    };

    settings = {
      mainBar = {
        position = "bottom";
        modules-left = [
          "sway/workspaces"
          "sway/mode"
        ];
        modules-right = [
          "mpd"
          "pulseaudio"
          "battery"
          "tray"
          "clock"
          "idle_inhibitor"
        ];

        battery = {
          "states" = {
            "warning" = 30;
            "critical" = 15;
          };
          "format-warning" = "{capacity}% {icon}";
          "format-critical" = "{capacity}% {icon}";
          "format-plugged" = "";
          "format-icons" = [
            ""
            ""
            ""
            ""
            ""
          ];
        };

        clock = {
          "format" = "{:%A, %B %d, %Y (%R)}";
        };

        "idle_inhibitor" = {
          "format" = "{icon}";
          "format-icons" = {
            "activated" = "";
            "deactivated" = "";
          };
        };

        "mpd" = {
          "format" = "{stateIcon} {artist} - {album} - {title} ";
          "format-paused" = "";
          "format-stopped" = "";
        };

        "pulseaudio" = {
          "format" = "{volume}% ";
          "format-muted" = "";
          "ignored-sinks" = [ "Easy Effects Sink" ];
        };

        tray = {
          "icon-size" = 20;
          spacing = 5;
        };
      };
    };
  };
}
