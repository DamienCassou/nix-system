{ pkgs, ... }:
{
  home = {
    file = {
      ".gnupg/gpg-agent.conf".text = ''
        enable-ssh-support
        pinentry-program ${pkgs.lib.getExe pkgs.pinentry_mac}
      '';
    };

    sessionPath = [ "/opt/homebrew/bin" ];
  };

  programs.firefox.package = pkgs.firefox-bin;

  services.syncthing.enable = true;
}
