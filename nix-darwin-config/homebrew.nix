{ ... }:
{
  environment.systemPath = [ "/opt/homebrew/bin" ];

  homebrew = {
    enable = true;
    brews = [
      "eugene1g/safehouse/agent-safehouse"
      "k6"
      "wireguard-tools"
      "wrkflw" # to test github action workflows locally
    ];
    casks = [
      "alfred"
      "android-platform-tools"
      "bluesnooze" # deactivate bluetooth while the computer sleeps
      "calibre"
      "copilot-cli"
      "element"
      "ghostty"
      "gimp"
      "hp-easy-start" # configure HP printers
      "inkscape"
      "jetbrains-toolbox"
      "jordanbaird-ice" # Simplifies macOS menu bar
      "karabiner-elements"
      "kid3" # id3 editor
      "launchcontrol"
      "libreoffice"
      "mattermost"
      "medis" # Redis client
      "microsoft-azure-storage-explorer"
      "mongodb-compass"
      "nextcloud"
      "rectangle"
      "signal"
      "slack"
      {
        # Force taking regular breaks
        name = "stretchly";
        args = {
          "no_quarantine" = true;
        };
      }
      "ungoogled-chromium"
      "visual-studio-code"
    ];
    onActivation = {
      autoUpdate = true;
      cleanup = "uninstall";
      extraFlags = [
        "--verbose"
        "--force-cleanup"
      ];
      upgrade = true;
    };
  };
}
