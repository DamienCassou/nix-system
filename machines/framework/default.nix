{ config, pkgs, ... }:

{
  imports = [
    ./borg.nix
    ./backup.nix
    ../../home-manager-config/common/syncthing.nix
    ../../secrets/syncthing/framework
  ];

  nixpkgs.overlays = [
    (import ./pkgs)
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  targets.genericLinux.enable = true;

  home.packages = with pkgs; [
    borgbackup
    hledger
    jq
    nix
    ponymix
    rofi
    signal-desktop
    thunderbird
    topgrade
    vlc
    wl-clipboard
  ];

  programs = {
    bash = {
      enable = true;
      shellAliases = {
        "hm" = "home-manager";
      };
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
            "cargo"
          ];
        };
        commands = {
          "Nix garbage collection" = "nix-collect-garbage --delete-older-than 10d";
        };
      };
    };

    browserpass = {
      enable = true;
      browsers = [
        "firefox"
        "chromium"
      ];
    };

    freetube = {
      enable = true;
      settings = {
        checkForUpdates = false;
        defaultQuality = "480";
      };
    };

    password-store = {
      enable = true;
      package = pkgs.pass.withExtensions (exts: [ exts.pass-otp ]);
      settings = {
        PASSWORD_STORE_DIR = "${config.home.homeDirectory}/.password-store";
      };
    };
  };

  home = {
    stateVersion = "24.11";
    username = "cassou";
    homeDirectory = "/home/cassou";
    sessionPath = [ "/home/cassou/.local/bin" ];
  };
}
