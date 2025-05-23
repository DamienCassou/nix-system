{ config, pkgs, ... }:

let
  nixGLWrap = config.lib.nixGL.wrap;
in
{
  imports = [
    ./desktop-entries.nix
  ];

  home = {
    packages = with pkgs; [
      (nixGLWrap calibre)
      (nixGLWrap element-desktop)
      (nixGLWrap ferdium) # for discord and mattermost
      (nixGLWrap parabolic) # download videos
      (nixGLWrap slack)
      (nixGLWrap teams-for-linux)
      (nixGLWrap vlc)
      arandr
      blueman
      brightnessctl
      dmidecode
      eog
      evince
      gimp
      inkscape
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
      virt-manager
      vscode
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

    signaturepdf = {
      enable = true;
      port = 9292;
      extraConfig = {
        upload_max_filesize = "200M";
        post_max_size = "200M";
        max_file_uploads = "200";
      };
    };
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
