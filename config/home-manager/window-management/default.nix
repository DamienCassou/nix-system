{ config, lib, ... }: {

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
          fullscreen_show_everything = { fullscreen = "show"; };
        };
      };

      flameshot = {
        enable = true;
        settings = {
          General = {
            checkForUpdates = false;
            disabledTrayIcon = true;
            savePathFixed = true;
            showStartupLaunchMessage = false;
            showDesktopNotification = false;
          };
        };
      };

      network-manager-applet = { enable = true; };
    };
  };
}
