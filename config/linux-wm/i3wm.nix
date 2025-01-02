{
  lib,
  config,
  pkgs,
  ...
}:

let
  generatedI3Config = (import ./build-i3OrSway.nix) {
    inherit pkgs config lib;
    showClipboardCommand = "exec ${pkgs.clipmenu}/bin/clipmenu -i";
    # We don't specify the nixpkgs path here
    # (${pkgs.i3lock}/bin/i3lock) to use the system's version if there
    # is one (e.g., /usr/bin/i3lock). This is because of
    # https://github.com/i3/i3lock/issues/286.
    lockScreenCommand = "exec ${config.services.screen-locker.lockCmd}";
    quitCommand = ''
      exec "${pkgs.i3}/bin/i3-nagbar -t warning -m 'You pressed the exit shortcut. Do you really want to exit i3? This will end your X session.' -B 'Yes, exit i3' '${pkgs.i3}/bin/i3-msg exit'"
    '';
  };
in
{
  config = lib.mkIf config.my.window-management.enable {
    xsession.windowManager.i3 = {
      enable = true;
      config = generatedI3Config // {
        bars = [
          (
            config.lib.stylix.sway.bar
            // {
              statusCommand = "${pkgs.i3status}/bin/i3status";
              inherit (config.xsession.windowManager.i3.config) fonts;
            }
          )
        ];
      };
    };

    services = {
      clipmenu = {
        enable = true;
        launcher = "rofi";
      };

      grobi = {
        enable = true;
        rules = [
          {
            name = "External screen";
            outputs_connected = [ "HDMI-2" ];
            configure_single = "HDMI-2";
            primary = "HDMI-2";
            atomic = true;
          }
          {
            name = "External screen through hub";
            outputs_connected = [ "DP-2" ];
            configure_single = "DP-2";
            primary = "DP-2";
            atomic = true;
          }
          {
            name = "Fallback";
            configure_single = "eDP-1";
            primary = "eDP-1";
            atomic = true;
          }
        ];
      };

      screen-locker = {
        enable = true;
        xautolock = {
          detectSleep = false; # lock screen when awaking laptop
        };
        lockCmd =
          # We don't specify the nixpkgs path here
          # (${pkgs.i3lock}/bin/i3lock) to use the system's version if
          # there is one (e.g., /usr/bin/i3lock). This is because of
          # https://github.com/i3/i3lock/issues/286.
          "i3lock --nofork --color=22529f --ignore-empty-password --show-failed-attempts";
      };

      redshift = {
        enable = true;
        package = pkgs.redshift.override { withGeolocation = false; };
        duskTime = "19:00-20:45";
        dawnTime = "05:00-06:45";
      };
    };

    xsession = {
      enable = true;
    };

    xresources = {
      properties = {
        "URxvt.scrollBar" = false;
      };
    };
  };
}
