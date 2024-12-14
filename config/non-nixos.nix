{ config, ... }:

let
  certificatesFile = "/etc/ssl/certs/ca-bundle.crt";
in
{
  accounts.email.certificatesFile = certificatesFile;

  systemd.user.systemctlPath = "/usr/bin/systemctl";

  targets.genericLinux.enable = true;

  home = {
    sessionVariables = {
      # So git finds the certificates on the woob clone:
      GIT_SSL_CAINFO = certificatesFile;
    };

    sessionVariablesExtra = ''
      export INFOPATH="/usr/share/info:${config.home.profileDirectory}/share/info:''${INFOPATH}"
    '';
  };
}
