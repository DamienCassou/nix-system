{
  pkgs,
  config,
  lib,
  showClipboardCommand,
  lockScreenCommand,
  quitCommand,
}:
let
  # use Super as my modifier
  modifier = "Mod4";
in
{
  modifier = modifier;
  defaultWorkspace = "workspace 1";
  focus.followMouse = false;
  fonts = {
    style = "Extrabold";
    size = lib.mkForce 12.0;
  };

  assigns = {
    # Call "xprop | grep WM_CLASS", click the window, and copy the 2nd
    # value
    "1" = [
      { class = "^Emacs$"; }
      { class = "^firefox$"; }
      { class = "^Chromium-browser$"; }
      { class = "^Google-chrome-unstable$"; }
      { instance = "^Cypress \\("; }
    ];
    "2" = [
      { class = "^Element"; }
      { class = "^Signal$"; }
      { class = "^Slack$"; }
      { class = "^teams-for-linux$"; }
    ];
    "3" = [
      { class = "^Gimp-2.10$"; }
      { class = "^Inkscape$"; }
      { class = "^Gnome-boxes$"; }
      { class = "^jetbrains-rider$"; }
      { class = "^org.remmina.Remmina$"; }
      { class = "^Virt-manager$"; }
    ];
    "4" = [ { instance = "^cypress$"; } ];
  };

  keybindings = {
    # program launcher and window switcher
    "--release ${modifier}+space" = ''exec "${pkgs.rofi}/bin/rofi -i -show combi -modi combi -show-icons -display-combi '?' -combi-modi window#drun -window-match-fields desktop#class"'';

    # Focus preferred windows:
    "Control+${modifier}+e" = ''[class = "^Emacs$"] focus'';
    "Control+${modifier}+f" = ''[class = "^firefox$"] focus'';
    "Control+${modifier}+m" = ''[class = "^Element$"] focus'';
    "Control+${modifier}+s" = ''[class = "^Slack$"] focus'';
    "Control+${modifier}+h" = ''[class = "^Chromium-browser$"] focus'';
    "Control+${modifier}+y" = ''[instance = "^Cypress \("] focus''; # Cypress test execution
    "Control+Shift+${modifier}+y" = ''[instance = "^cypress$"] focus''; # Cypress test suite list

    # notifications
    "${modifier}+k" = "exec ${pkgs.dunst}/bin/dunstctl close";
    "${modifier}+p" = "exec ${pkgs.dunst}/bin/dunstctl history-pop";

    "--release ${modifier}+c" = showClipboardCommand;

    # mpd integration
    "--release ${modifier}+z" = "exec rofi-mpd.sh";

    # Volume
    "XF86AudioRaiseVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ '+10%'";
    "Shift+XF86AudioRaiseVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ '+5%'";

    "XF86AudioLowerVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ '-10%'";
    "Shift+XF86AudioLowerVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ '-5%'";

    "XF86AudioMute" = "exec pactl set-sink-mute @DEFAULT_SINK@ toggle";
    "XF86AudioMicMute" = "exec pactl set-source-mute @DEFAULT_SOURCE@ toggle";

    # Brightness
    "XF86MonBrightnessDown" = ''exec brightnessctl set "5%-"'';
    "XF86MonBrightnessUp" = ''exec brightnessctl set "+5%"'';

    # Printscreen
    "--release Print" = ''exec "${pkgs.flameshot}/bin/flameshot full --clipboard --path ~/Pictures"'';
    "--release Shift+Print" = ''exec "${pkgs.flameshot}/bin/flameshot gui --clipboard --path ~/Pictures"'';

    # Lockscreen
    "--release ${modifier}+l" = lockScreenCommand;

    # Emacs everywhere
    "--release ${modifier}+u" = "exec ${config.programs.emacs.package}/bin/emacsclient --eval '(emacs-everywhere)'";

    # Change focus
    "${modifier}+n" = "focus left";
    "${modifier}+e" = "focus down";
    "${modifier}+i" = "focus up";
    "${modifier}+o" = "focus right";

    # Move focused container around
    "${modifier}+Shift+n" = "move left";
    "${modifier}+Shift+e" = "move down";
    "${modifier}+Shift+i" = "move up";
    "${modifier}+Shift+o" = "move right";

    # Change layout
    "${modifier}+w" = "layout tabbed";
    "${modifier}+h" = "split h";

    # Kill application
    "${modifier}+q" = "kill";

    "${modifier}+1" = "workspace 1";
    "${modifier}+2" = "workspace 2";
    "${modifier}+3" = "workspace 3";
    "${modifier}+4" = "workspace 4";
    "${modifier}+5" = "workspace 5";
    "${modifier}+6" = "workspace 6";
    "${modifier}+7" = "workspace 7";
    "${modifier}+8" = "workspace 8";
    "${modifier}+9" = "workspace 9";
    "${modifier}+0" = "workspace 10";

    # Move focused container to workspace
    "${modifier}+Shift+1" = "move container to workspace 1";
    "${modifier}+Shift+2" = "move container to workspace 2";
    "${modifier}+Shift+3" = "move container to workspace 3";
    "${modifier}+Shift+4" = "move container to workspace 4";
    "${modifier}+Shift+5" = "move container to workspace 5";
    "${modifier}+Shift+6" = "move container to workspace 6";
    "${modifier}+Shift+7" = "move container to workspace 7";
    "${modifier}+Shift+8" = "move container to workspace 8";
    "${modifier}+Shift+9" = "move container to workspace 9";
    "${modifier}+Shift+0" = "move container to workspace 10";

    "${modifier}+a" = "mode Control";
  };

  modes = {
    Control = {
      "${modifier}+a" = "mode default";

      # reload the configuration file
      "c" = "reload";

      # restart i3 inplace
      "r" = "restart";

      # exit i3
      "q" = quitCommand;

      "f" = "floating toggle";

      # Resize container:
      "n" = "resize shrink width 10 px or 10 ppt";
      "e" = "resize grow height 10 px or 10 ppt";
      "i" = "resize shrink height 10 px or 10 ppt";
      "o" = "resize grow width 10 px or 10 ppt";
    };
  };

  window.commands = [
    {
      criteria = {
        class = ".*";
      };
      command = "border pixel 8";
    }
    {
      criteria = {
        class = ".*";
      };
      command = ''title_format "<b>%class</b>"'';
    }
    {
      criteria = {
        class = "Slack";
        title = "Slack";
      };
      command = "floating disable, move container to workspace 2";
    }
  ];
}
