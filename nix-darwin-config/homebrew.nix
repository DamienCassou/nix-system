{ ... }:
{
  homebrew = {
    enable = true;
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
