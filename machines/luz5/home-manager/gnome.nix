{ lib, ... }:

with lib.hm.gvariant;
{
  # Generated via dconf2nix: https://github.com/gvolpe/dconf2nix
  dconf.settings = {
    "org/gnome/desktop/input-sources" = {
      sources = [
        (mkTuple [
          "xkb"
          "us+colemak"
        ])
      ];
      xkb-options = [ "caps:ctrl_shifted_capslock" ];
    };

    "org/gnome/desktop/interface" = {
      icon-theme = "Adwaita";
      show-battery-percentage = true;
    };

    "org/gnome/desktop/wm/keybindings" = {
      # Don't bind "Alt+space" to window menu as I use it for Emacs
      activate-window-menu = [ ];
    };

    "org/gnome/evolution-data-server" = {
      migrated = true;
    };

    "org/gnome/gnome-system-monitor" = {
      current-tab = "processes";
      maximized = true;
      show-dependencies = false;
      show-whose-processes = "all";
    };

    "org/gnome/settings-daemon/plugins/housekeeping" = {
      donation-reminder-last-shown = mkInt64 1769880998996827;
    };

    "org/gnome/shell" = {
      favorite-apps = [ ];
      last-selected-power-profile = "performance";
      remember-mount-password = false;
      welcome-dialog-last-shown-version = "49.2";
    };

    "org/gnome/shell/world-clocks" = {
      locations = [ ];
    };

    "org/gnome/tweaks" = {
      show-extensions-notice = false;
    };

  };
}
