{ ... }:
{
  homebrew = {
    enable = true;
    brews = [
      "k6"
      "node" # for Wox
    ];
    casks = [
      "calibre"
      "discord"
      "eloston-chromium"
      "element"
      "gimp"
      "inkscape"
      "jetbrains-toolbox"
      "jordanbaird-ice"
      "launchcontrol"
      "libreoffice"
      "mattermost"
      "microsoft-azure-storage-explorer"
      "mongodb-compass"
      "rectangle"
      "signal"
      "slack"
      "visual-studio-code"
      "wox"
    ];
    taps = [
      "wox-launcher/wox"
    ];
    onActivation = {
      cleanup = "uninstall";
      extraFlags = [ "--verbose" ];
    };
  };
}
