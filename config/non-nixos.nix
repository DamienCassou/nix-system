{ config, lib, ... }:
{
  systemd.user.systemctlPath = "/usr/bin/systemctl";

  targets.genericLinux.enable = true;

  home.sessionVariables = {
    # https://nixos.org/nixpkgs/manual/#locales
    NIX_PATH = "/home/cassou/Documents/projects/nix-system";
  };

  pam.sessionVariables = {
    NIX_PATH = "/home/cassou/Documents/projects/nix-system";
  };

  systemd.user.sessionVariables.NIX_PATH = lib.mkForce "/home/cassou/Documents/projects/nix-system";

  home.sessionVariablesExtra = ''
    export INFOPATH="/usr/share/info:${config.home.profileDirectory}/share/info:''${INFOPATH}"
    export NIX_PATH="/home/cassou/Documents/projects/nix-system"
  '';

  xsession.profileExtra = ''
    export NIX_PATH="/home/cassou/Documents/projects/nix-system"
  '';

  xsession.initExtra = ''
    export NIX_PATH="/home/cassou/Documents/projects/nix-system"
  '';

  imports = [ ./common ];
}
