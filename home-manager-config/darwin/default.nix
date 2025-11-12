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
    };
  };

  launchd = {
    enable = true;
    agents = {
      setProfileEnvVariables = {
        enable = true;
        config =
          let
            vars = config.home.sessionVariables // {
              SSH_AUTH_SOCK = "${config.home.homeDirectory}/.gnupg/S.gpg-agent.ssh";
            };
            # List of variable names and values looking like (VAR1 VAL1
            # VAR2 VAL2 …):
            variableAndValues = (
              lib.flatten (
                lib.mapAttrsToList (varName: varValue: [
                  varName
                  (builtins.toString varValue)
                ]) vars
              )
            );
          in
          {
            ProgramArguments = [
              "launchctl"
              "setenv"
            ]
            ++ variableAndValues;
            RunAtLoad = true;
          };
      };
    };
  };

  targets.darwin = {
    defaults = {
      NSGlobalDomain = {
        AppleShowAllExtensions = true;
      };
      "com.apple.controlcenter".BatteryShowPercentage = true;
      "com.apple.desktopservices" = {
        DSDontWriteNetworkStores = true;
        DSDontWriteUSBStores = true;
      };
      "com.apple.dock" = {
        autohide = true;
      };
      "com.apple.finder" = {
        AppleShowAllFiles = true;
        ShowPathBar = true;
      };
    };
    search = "DuckDuckGo";
  };
}
