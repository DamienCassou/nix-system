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
    ./documentation.nix
    ./emacs.nix
    ./email
    ./git.nix
    ./gpg.nix
    ./music.nix
    ./my-packages
    ./my-scripts.nix
    ./nix.nix
    ./packages.nix
    ./pim
    ./report-changes.nix
    ./ssh.nix
    ./stylix
    ./syncthing.nix
    ./web.nix
  ];

  programs = {
    bashmount = {
      enable = true;
    };

    direnv = {
      enable = true;
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

  home = {
    stateVersion = "24.11";
    enableNixpkgsReleaseCheck = false;

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
