{ ... }:
{
  homebrew = {
    enable = true;
    brews = [
      "k6"
      "node" # for Wox
    ];
    casks = [
      "android-platform-tools"
      "calibre"
      "discord"
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
      "ungoogled-chromium"
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
