{ ... }:
{
  homebrew = {
    enable = true;
    brews = [
      "k6"
      "wireguard-tools"
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
      "tageditor" # for id3 tags
      "ungoogled-chromium"
      "visual-studio-code"
    ];
    onActivation = {
      cleanup = "uninstall";
      extraFlags = [ "--verbose" ];
    };
  };
}
