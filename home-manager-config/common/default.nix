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
    ./my-packages
    ./my-scripts.nix
    ./nix.nix
    ./packages.nix
    ./pim
    ./report-changes.nix
    ./ssh.nix
    ./stylix
    ./syncthing.nix
    ./web
  ];

  programs = {
    bashmount = {
      enable = true;
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
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

  xdg = {
    enable = true;
    configFile."nixpkgs/config.nix".source = ./nixpkgs-config.nix;
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
