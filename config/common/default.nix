{
  lib,
  config,
  pkgs,
  ...
}:

let
  home = config.home.homeDirectory;
  certificatesFile = "/etc/ssl/certs/ca-bundle.crt";
  systemdEmail = pkgs.writeShellScript "systemd-email.sh" ''
    ${pkgs.msmtp}/bin/sendmail -t <<ERRMAIL
    To: $1
    From: systemd <root@$HOSTNAME>
    Subject: $2
    Content-Transfer-Encoding: 8bit
    Content-Type: text/plain; charset=UTF-8

    $(systemctl status --user --full "$2")
    ERRMAIL
  '';
in
{
  imports = [
    ./bin.nix
    ./borg.nix
    ./dev.nix
    ./desktop-entries.nix
    ./docker.nix
    ./documentation.nix
    ./email.nix
    ./packages.nix
    ./pim.nix
    ./report-changes.nix
    ./scripts
    ./stylix.nix
    ./syncthing.nix
    ./web.nix
  ];

  my.window-management.enable = true;

  systemd.user = {
    # Automatically start new services and stop old ones:
    startServices = true;
    services = {
      # https://wiki.archlinux.org/title/Systemd/Timers#MAILTO
      "status_email_user@" = {
        Unit = {
          Description = "status email for %i";
        };
        Service = {
          Type = "oneshot";
          ExecStart = "${systemdEmail} ${config.accounts.email.accounts.perso.address} %i";
        };
      };
    };
  };

  programs = {
    bashmount = {
      enable = true;
    };

    direnv = {
      enable = true;
      enableBashIntegration = true;
      nix-direnv.enable = true;
    };

    freetube = {
      enable = true;
      settings = {
        checkForUpdates = false;
        defaultQuality = "480";
      };
    };

    home-manager = {
      enable = true;
    };

    htop = {
      enable = true;
      settings = {
        color_scheme = 6;
      };
    };

    nix-index-database.comma.enable = true;
    nix-index.enableBashIntegration = true;

    password-store = {
      enable = true;
      package = pkgs.pass.withExtensions (exts: [ exts.pass-otp ]);
      settings = {
        PASSWORD_STORE_DIR = "${home}/.password-store";
      };
    };

    ripgrep = {
      enable = true;
    };

    rofi = {
      enable = true;
      cycle = true;
    };

    topgrade = {
      enable = true;
      settings = {
        linux = {
          home_manager_arguments = [
            "--flake"
            (lib.elemAt config.nix.nixPath 0)
          ];
        };
        misc = {
          assume_yes = true;
          disable = [
            "nix"
            "emacs"
            "pipx"
            "stack"
            "node"
            "gem"
            "git_repos"
            "bun"
          ];
          remote_topgrades = [ "librem14" ];
        };
        commands = {
          "Emacs submodules" = "git -C ~/.emacs.d fetch --recurse-submodules -j 4";
          "Nix-system submodules" = "git -C ~/Documents/projects/nix-system fetch --recurse-submodules -j 4";
          "Nix garbage collection" = "nix-collect-garbage --delete-older-than 10d";
          "Vdirsyncer" = "vdirsyncer sync";
        };
      };
    };

    yt-dlp = {
      enable = true;
    };
  };

  gtk = {
    enable = true;
    iconTheme = {
      package = pkgs.adwaita-icon-theme;
      name = "Adwaita";
    };
    gtk3 = {
      bookmarks = [
        "file://${home}/Documents"
        "file://${home}/Documents/projects/ftgp"
        "file://${home}/Documents/projects/ftgp/finsit/monitor/monitor/Monitor.Test/Helpers/Files/Sie"
        "file://${home}/Documents/projects/ftgp/finsit/monitor/monitor/Monitor.Web.Ui/Client"
        "file://${home}/Downloads"
        "file://${home}/Music"
        "file://${home}/Pictures"
        "file:///tmp"
      ];
    };
  };

  services = {
    mpd = {
      enable = true;
      playlistDirectory = config.xdg.userDirs.music + "../playlists";
    };

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
    enable = true;
    userDirs = {
      enable = true;
      music = "${home}/Music/son/";
    };
    configFile."nixpkgs/config.nix".source = ./nixpkgs-config.nix;
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
  };

  fonts.fontconfig.enable = true;

  accounts.email.certificatesFile = certificatesFile;

  nix = {
    package = pkgs.nix;
    nixPath = [ "${home}/Documents/projects/nix-system" ];
    channels = { };
    keepOldNixPath = false;
    settings = {
      experimental-features = [
        "flakes"
        "nix-command"
      ];
      substituters = [
        "https://cache.nixos.org"
        "https://devenv.cachix.org"
        "https://emacs-ci.cachix.org"
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
        "emacs-ci.cachix.org-1:B5FVOrxhXXrOL0S+tQ7USrhjMT5iOPH+QN9q0NItom4="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
    registry = {
      "flakes" = {
        from = {
          id = "nixpkgs";
          type = "indirect";
        };
        to = {
          path = "${home}/Documents/projects/nix-system/nixpkgs";
          type = "path";
        };
      };
    };
  };

  home = {
    stateVersion = "23.11";
    enableNixpkgsReleaseCheck = false;

    homeDirectory = "/home/cassou";
    username = "cassou";

    keyboard = {
      layout = "us";
      variant = "colemak";
      options = [ "ctrl:nocaps" ];
    };

    sessionPath = [
      "${home}/.local/bin"
      config.home.sessionVariables.DOTNET_ROOT
      "${config.home.sessionVariables.DOTNET_ROOT}/tools"
    ];

    sessionVariables = {
      LEDGER_FILE = "${home}/configuration/ledger/accounting.hledger";
      # So git finds the certificates on the woob clone:
      GIT_SSL_CAINFO = certificatesFile;

      CLEAR_CONSOLE = "false";

      # Prevent .NET Core from sending usage statistics:
      DOTNET_CLI_TELEMETRY_OPTOUT = "true";

      # Tell dotnet where to find the installations
      DOTNET_ROOT = "${home}/.dotnet";

      MAILDIR = "${home}/Mail";

      # I need this variable to be accessible from desktop
      # applications, not only from shell sessions. Using
      # pass-show-password doesn't seem to work for desktop
      # applications, maybe because gpg isn't ready when the session
      # variables are initially set.
      # The error message I get is:
      # > Value: gpg: public key decryption failed: No such file or directory
      # > gpg: decryption failed: No such file or directory
      FINSIT_GITHUB = "$(cat ${home}/Documents/projects/nix-system/secrets/FINSIT_GITHUB)";

      GITHUB_ACTOR = "DamienCassou"; # Used by C# nuget configuration
      NPM_JFROG_TOKEN = "$(pass-show-password wk/jfrog.io/token)";

      ESLINT_USE_FLAT_CONFIG = "true";
    };

    extraOutputsToInstall = [
      "doc"
      "devdoc"
    ];
  };
}
