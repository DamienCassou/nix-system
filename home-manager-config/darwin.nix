{
  config,
  lib,
  pkgs,
  ...
}:
{
  home = {
    file = {
      ".gnupg/gpg-agent.conf".text = ''
        enable-ssh-support
        pinentry-program ${pkgs.lib.getExe pkgs.pinentry_mac}
      '';

      # Make all sessionVariables available to non-shell applications
      # by adding them to launchd:
      "Library/LaunchAgents/damien.plist".text =
        let
          vars = config.home.sessionVariables;
          # List of variable names and values looking like (VAR1 VAL1
          # VAR2 VAL2 …):
          variableAndValues = (
            lib.flatten (
              lib.mapAttrsToList (varName: varValue: [
                varName
                varValue
              ]) vars
            )
          );
        in
        lib.generators.toPlist { } {
          Label = "damien";
          ProgramArguments = [
            "launchctl"
            "setenv"
          ] ++ variableAndValues;
          RunAtLoad = true;
        };
    };

    sessionPath = [ "/opt/homebrew/bin" ];
  };

  programs.firefox.package = pkgs.firefox-bin;

  services = {
    mpd.musicDirectory = "${config.home.homeDirectory}/personal/music/damien";
    syncthing.enable = true;};
}
