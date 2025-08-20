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
      "stretchly"
      "ungoogled-chromium"
      "visual-studio-code"
    ];
    onActivation = {
      cleanup = "uninstall";
      extraFlags = [ "--verbose" ];
    };
  };
}
