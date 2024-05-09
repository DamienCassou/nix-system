{ pkgs, ... }:
{
  programs.gpg = {
    enable = true;
    settings = {
      # Get rid of the copyright notice
      no-greeting = true;
      # Always encrypt to myself as well (useful for emails)
      encrypt-to = "8E64FBE545A394F5D35CD202F72C652AE7564ECC";
      keyserver = "hkp://keys.gnupg.net";
    };
    scdaemonSettings = {
      # Avoid conflicts with the global pcscd service:
      # disable-ccid = true;
    };
  };

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    pinentryPackage = pkgs.pinentry-gnome3;
  };
}
