{ pkgs, ... }:
{
  imports = [
    ./borg.nix
    ./desktop-entries.nix
  ];

  home = {
    packages = with pkgs; [
      arandr
      blueman
      brightnessctl
      dmidecode
      networkmanager # for nmcli
      pavucontrol
      pciutils
      pulseaudio
      rofi-bluetooth
      rofi-pulse-select
      xdg-utils
      xorg.xmodmap
      xorg.xrdb
      xorg.xset
    ];

  };

  programs = {
    bash.shellAliases = {
      "dnf-list" = "dnf repoquery --list";
      "dnf-provides" = "dnf repoquery --cacheonly --file";
    };

    rofi = {
      enable = true;
      cycle = true;
    };
  };

  services = {
    poweralertd.enable = true;
    safeeyes.enable = true;

    snixembed = {
      enable = true;

      beforeUnits = [
        # https://github.com/slgobinath/SafeEyes/wiki/How-to-install-backend-for-Safe-Eyes-tray-icon
        "safeeyes.service"
      ];
    };

    systembus-notify.enable = true;
  };

  xdg = {
    mime.enable = true;
    mimeApps = {
      enable = true;
      defaultApplications = {
        "x-scheme-handler/mailto" = "emacsclient-mail.desktop";
        "x-scheme-handler/msteams" = "teams-for-linux.desktop";
        "x-scheme-handler/magnet" = "transmission-gtk.desktop";
        "x-scheme-handler/http" = "firefox.desktop";
        "x-scheme-handler/https" = "firefox.desktop";
      };
    };
    userDirs.enable = true;
  };
}
