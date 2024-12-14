{
  lib,
  config,
  pkgs,
  ...
}:

let
  home = config.home.homeDirectory;
in
{
  imports = [
    ./backup
    ./bash.nix
    ./dev
    ./docker.nix
    ./documentation.nix
    ./emacs.nix
    ./email
    ./git.nix
    ./gpg.nix
    ./my-packages
    ./my-scripts.nix
    ./packages.nix
    ./pim
    ./report-changes.nix
    ./ssh.nix
    ./stylix
    ./syncthing.nix
    ./web.nix
  ];

  my.window-management.enable = true;

  systemd.user = {
    # Automatically start new services and stop old ones:
    startServices = true;
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
          "Nix-system submodules" =
            "git -C ${lib.elemAt config.nix.nixPath 0} fetch --recurse-submodules -j 4";
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
        "file://${home}/personal"
        "file://${home}/work"
        "file://${home}/work/setup/monitor/monitor/Monitor.Test/Helpers/Files/Sie"
        "file://${home}/Downloads"
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
      music = "${home}/personal/music/damien/";
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

  nix = {
    package = pkgs.nix;
    nixPath = [ "${home}/personal/nix-system" ];
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
          path = "${lib.elemAt config.nix.nixPath 0}/nixpkgs";
          type = "path";
        };
      };
    };
  };

  home = {
    stateVersion = "24.11";
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
    ];

    sessionVariables = {
      LEDGER_FILE = "${home}/personal/ledger/accounting.hledger";
    };
  };
}
