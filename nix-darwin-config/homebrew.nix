{ ... }:
{
  homebrew = {
    enable = true;
    brews = [
      "node" # for Wox
    ];
    casks = [
      "calibre"
      "eloston-chromium"
      "element"
      "ferdium"
      "gimp"
      "inkscape"
      "jetbrains-toolbox"
      "jordanbaird-ice"
      "launchcontrol"
      "libreoffice"
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
