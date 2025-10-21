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
      "element"
      "ghostty"
      "gimp"
      "halloy" # Client IRC
      "hp-easy-start" # configure HP printers
      "inkscape"
      "jetbrains-toolbox"
      "jordanbaird-ice" # Simplifies macOS menu bar
      "krita"
      "launchcontrol"
      "libreoffice"
      "mattermost"
      "microsoft-azure-storage-explorer"
      "mongodb-compass"
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
      cleanup = "uninstall";
      extraFlags = [ "--verbose" ];
    };
  };
}
