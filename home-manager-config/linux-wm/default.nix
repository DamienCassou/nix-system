{ config, lib, ... }:
{

  imports = [
    ./i3status.nix
    ./i3wm.nix
    # ./sway.nix
  ];

  options.my.window-management = with lib; {
    enable = mkEnableOption "Window management";
  };

  config = lib.mkIf config.my.window-management.enable {
    services = {
      dunst = {
        enable = true;
        settings = {
          global = {
            word_wrap = true;
            shrink = false;
            frame_width = 2;
            offset = "0x0";
            icon_position = "left";
            max_icon_size = 100;
          };
          fullscreen_show_everything = {
            fullscreen = "show";
          };
        };
      };

      flameshot = {
        enable = true;
        settings = {
          General = {
            disabledTrayIcon = true;
            savePathFixed = true;
            showStartupLaunchMessage = false;
            showDesktopNotification = false;
          };
        };
      };

      network-manager-applet = {
        enable = true;
      };
      caffeine.enable = true;

      poweralertd.enable = true;
      safeeyes.enable = false;

      snixembed = {
        enable = true;

        beforeUnits = [
          # https://github.com/slgobinath/SafeEyes/wiki/How-to-install-backend-for-Safe-Eyes-tray-icon
          "safeeyes.service"
        ];
      };

      systembus-notify.enable = true;
    };
  };
}
