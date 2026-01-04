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
      "hammerspoon" # for nohzafk/emacs-anywhere
      "hp-easy-start" # configure HP printers
      "inkscape"
      "jetbrains-toolbox"
      "jordanbaird-ice" # Simplifies macOS menu bar
      "karabiner-elements"
      "krita"
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
      cleanup = "uninstall";
      extraFlags = [ "--verbose" ];
    };
  };
}
