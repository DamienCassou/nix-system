{ config, pkgs, ... }:

let
  nixGLWrap = config.lib.nixGL.wrap;
in
{
  imports = [
    ./borg.nix
    ./desktop-entries.nix
  ];

  home = {
    packages = with pkgs; [
      (nixGLWrap calibre)
      (nixGLWrap ferdium) # for discord and mattermost
      (nixGLWrap parabolic) # download videos
      (nixGLWrap teams-for-linux)
      (nixGLWrap vlc)
      arandr
      blueman
      brightnessctl
      dmidecode
      eog
      evince
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
    bash = {
      profileExtra = ''
        # Deactivate the audible bell in X
        xset -b
      '';

      shellAliases = {
        "dnf-list" = "dnf repoquery --list";
        "dnf-provides" = "dnf repoquery --cacheonly --file";
      };
    };

    freetube = {
      enable = true;
      settings = {
        checkForUpdates = false;
        defaultQuality = "480";
      };
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
    emacs = {
      enable = true;
      defaultEditor = true;
      socketActivation.enable = true;
      startWithUserSession = "graphical";
    };

    gpg-agent = {
      enable = true;
      enableSshSupport = true;
      pinentryPackage = pkgs.pinentry-gnome3;
    };

    poweralertd.enable = true;
    safeeyes.enable = true;

    signaturepdf = {
      enable = true;
      port = 9292;
      extraConfig = {
        upload_max_filesize = "200M";
        post_max_size = "200M";
        max_file_uploads = "200";
      };
    };

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
