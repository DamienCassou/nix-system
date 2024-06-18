{
  lib,
  config,
  pkgs,
  ...
}:
let
  lockScreenCommand = "/usr/bin/swaylock";
  generatedSwayConfig = (import ./build-i3OrSway.nix) {
    inherit pkgs config lib;
    showClipboardCommand = "exec ${lib.getExe config.services.copyq.package} menu";
    # We use the system's swaylock because a file is required in
    # /etc/pam.d
    lockScreenCommand = "exec ${lockScreenCommand}";
    quitCommand = ''
      exec "${pkgs.sway}/bin/swaynag -t warning -m 'You pressed the exit shortcut. Do you really want to exit sway?' -B 'Yes, exit Sway' '${pkgs.sway}/bin/swaymsg exit'"
    '';
  };
in
{
  imports = [ ./waybar.nix ];

  wayland.windowManager.sway = {
    enable = true;
    config = generatedSwayConfig // {
      bars = [ ];
      input = {
        "*" = {
          xkb_layout = "us";
          xkb_variant = "colemak";
          xkb_options = "ctrl:nocaps";
        };
      };
    };
  };

  services = {
    copyq.enable = true;

    kanshi = {
      enable = true;
      profiles = {
        # When both a Dell and the laptop screen are found, only turn on the Dell
        home = {
          outputs = [
            { criteria = "HDMI-A-2"; }
            {
              criteria = "eDP-1";
              status = "disable";
            }
          ];
        };
      };
    };

    gammastep = {
      enable = true;
      package = pkgs.gammastep.override { withGeolocation = false; };
      duskTime = "19:00-20:45";
      dawnTime = "05:00-06:45";
    };

    swayidle = {
      enable = true;
      extraArgs = [ "-d" ];
      events = [
        {
          # lock the screen before sleeping
          event = "before-sleep";
          command = "${lockScreenCommand} -f";
        }
        {
          # lock the screen when logind signals the session should
          # be locked
          event = "lock";
          command = "${lockScreenCommand} -f";
        }
      ];
      timeouts = [
        {
          # lock screen after 3 minute
          timeout = 180;
          command = "${lockScreenCommand}";
        }
        {
          # turn off displays after 10 minutes
          timeout = 600;
          command = ''${pkgs.sway}/bin/swaymsg "output * dpms off"'';
          resumeCommand = ''${pkgs.sway}/bin/swaymsg "output * dpms on"'';
        }
      ];
    };
  };

  programs.kitty = {
    enable = true;
  };

  # Only start the Emacs daemon after sway. This is useful so Emacs
  # gets all sway's environment variables:
  systemd.user.services.emacs = lib.mkIf config.services.emacs.enable {
    Unit = {
      After = [ "sway-session-pre.target" ];
      PartOf = [ "sway-session.target" ];
    };

    Install.WantedBy = lib.mkForce [ "sway-session.target" ];
  };

  # This file must be referenced by
  # /usr/share/wayland-sessions/sway.desktop on non-NixOS systems:
  home.file.".sway-session".source = pkgs.writeShellScript "sway-session" ''
    # Make sure systemd services know about SSH_AUTH_SOCK:
    systemctl --user import-environment SSH_AUTH_SOCK

    exec ${lib.getExe pkgs.nixGLIntel} ${lib.getExe pkgs.sway} "$@" 2>&1 > /tmp/sway.log
  '';
}
