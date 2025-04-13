{ ... }:
{
  homebrew = {
    enable = true;
    casks = [
      "alfred"
      "alt-tab"
      "calibre"
      # https://github.com/CtrlSpice/homebrew-otel-desktop-viewer/issues/2
      # "DamienCassou/otel-desktop-viewer/otel-desktop-viewer"
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
    ];
    taps = [
      "DamienCassou/homebrew-otel-desktop-viewer"
    ];
  };
}
