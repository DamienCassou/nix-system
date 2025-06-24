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
      "wireshark"
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
