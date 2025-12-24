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
    ./nix.nix
    ./packages.nix
    ./pim
    ./report-changes.nix
    ./ssh.nix
    ../../secrets/home-manager.nix
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
            "rubygems"
          ];
          remote_topgrades = [ "framework" ];
        };
        commands = {
          "Emacs submodules" = "git -C ~/.emacs.d fetch --recurse-submodules -j 4";
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
    stateVersion = "25.05";
    enableNixpkgsReleaseCheck = false;

    keyboard = {
      layout = "us";
      variant = "colemak";
      options = [ "ctrl:nocaps" ];
    };

    packages = [
      (import ./my-scripts.nix { inherit lib pkgs; })
    ];

    sessionPath = [
      "${home}/.local/bin"
    ];

    sessionVariables = {
      LEDGER_FILE = "${home}/personal/ledger/accounting.hledger";
    };
  };
}
