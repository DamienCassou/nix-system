{ ... }:
let
  certificatesFile = "/etc/ssl/certs/ca-bundle.crt";
in
{
  imports = [
    ./desktop-entries.nix
  ];

  accounts.email.certificatesFile = certificatesFile;

  home = {
    sessionVariables = {
      # So git finds the certificates on the woob clone:
      GIT_SSL_CAINFO = certificatesFile;
    };
  };

  programs.bash.shellAliases = {
    "dnf-list" = "dnf repoquery --list";
    "dnf-provides" = "dnf repoquery --cacheonly --file";
  };

  systemd.user = {
    # Automatically start new services and stop old ones:
    startServices = true;
  };
}
