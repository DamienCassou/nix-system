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
      "discord"
      "element"
      "gimp"
      "halloy" # Client IRC
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
      "stretchly" # Force taking regular breaks
      "ungoogled-chromium"
      "visual-studio-code"
    ];
    onActivation = {
      cleanup = "uninstall";
      extraFlags = [ "--verbose" ];
    };
  };
}
