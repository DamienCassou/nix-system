{ config, pkgs, ... }:

{
  systemd.user.systemctlPath = "/usr/bin/systemctl";

  targets.genericLinux.enable = true;

  home = {
    sessionSearchVariables.INFOPATH = [
      "/usr/share/info"
      "${config.home.profileDirectory}/share/info"
    ];
  };

  nix.package = pkgs.nix;
}
