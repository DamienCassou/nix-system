{ config, ... }:
{
  systemd.user.systemctlPath = "/usr/bin/systemctl";

  targets.genericLinux.enable = true;

  home.sessionVariablesExtra = ''
    export INFOPATH="/usr/share/info:${config.home.profileDirectory}/share/info:''${INFOPATH}"
  '';

  imports = [ ./common ];
}
