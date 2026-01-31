{ config, pkgs, ... }:

{
  systemd.user.systemctlPath = "/usr/bin/systemctl";

  targets.genericLinux = {
    enable = true;

    nixGL = {
      packages = pkgs.nixgl;
      installScripts = [ "mesa" ];
    };
  };

  home = {
    sessionSearchVariables.INFOPATH = [
      "/usr/share/info"
      "${config.home.profileDirectory}/share/info"
    ];
  };

  nix.package = pkgs.nix;
}
