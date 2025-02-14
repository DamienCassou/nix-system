{ config, pkgs, ... }:

let
  nixGLWrap = config.lib.nixGL.wrap;
in
{
  imports = [
    ./borg.nix
    ./desktop-entries.nix
    ./music.nix
    ./web
  ];

  home = {
    packages = with pkgs; [
      (nixGLWrap calibre)
      (nixGLWrap ferdium) # for discord and mattermost
      (nixGLWrap parabolic) # download videos
      (nixGLWrap vlc)
      arandr
      blueman
      brightnessctl
      dmidecode
      libreoffice
      networkmanager # for nmcli
      nitrokey-app2
      pavucontrol
      pciutils
      peek # for screencasts
      psmisc # for killall
      pulseaudio
      pynitrokey
      rofi
      rofi-bluetooth
      rofi-pulse-select
      usbutils
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

    ghostty = {
      enable = true;
      package = config.lib.nixGL.wrap pkgs.ghostty;
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
