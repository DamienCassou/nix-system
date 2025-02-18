{ lib, pkgs, ... }:
{
  environment = {
    extraOutputsToInstall = [
      "devdoc"
      "doc"
      "info"
    ];

    shells = [ pkgs.bashInteractive ];
  };

  homebrew = {
    enable = true;
    brews = [
      {
        name = "colima";
        start_service = true;
      }
      "docker"
      "docker-buildx"
      "docker-compose"
    ];
    casks = [
      "jetbrains-toolbox"
      "rectangle"
      "eloston-chromium"
    ];
  };

  launchd.user = {
    agents.setenv.serviceConfig =
      let
        vars = {
          HOMEBREW_PREFIX = "/opt/homebrew";
          HOMEBREW_CELLAR = "/opt/homebrew/Cellar";
          HOMEBREW_REPOSITORY = "/opt/homebrew";
        };
      in
      {
        ProgramArguments =
          [
            "launchctl"
            "setenv"
          ]
          ++ (lib.flatten (
            lib.mapAttrsToList (varName: varValue: [
              varName
              varValue
            ]) vars
          ));
        RunAtLoad = true;
      };
  };

  nix.settings = {
    experimental-features = "nix-command flakes";
    trusted-users = [ "cassou" ];
  };

  nixpkgs.hostPlatform = "aarch64-darwin";

  programs = {
    bash = {
      enable = true;
      completion.enable = true;
    };
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };

  security = {
    pam.enableSudoTouchIdAuth = true;
  };

  system = {
    defaults.dock.autohide = true;
    stateVersion = 6;
  };

  users.users.cassou = {
    home = "/Users/cassou";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPNt/RcAiO+zgCvPUBXGHwPRr1qpufb/+tZlSab5D0cM cardno:000F_F29888AB"
    ];
    shell = pkgs.bashInteractive;
  };
}
