{ config, pkgs, ... }:
{
  programs.browserpass = {
    enable = true;
    browsers = [
      "firefox"
      "chromium"
    ];
  };

  # Manual steps:
  # 1. Open chromium
  # 2. Go to https://github.com/NeverDecaf/chromium-web-store/releases/latest and download CRX to install extension
  # 2. Go to https://chromewebstore.google.com/detail/browserpass/naepdomgkenhinolocfifgehidddafch and install
  programs.chromium = {
    enable = false;
    package = config.lib.nixGL.wrap pkgs.ungoogled-chromium;
    commandLineArgs = [
      # Necessary to install addons on ungoogled-chromium. See:
      # https://github.com/NeverDecaf/chromium-web-store?tab=readme-ov-file#chromium-web-store
      "--extension-mime-request-handling=always-prompt-for-install"
      "--enable-features=ClearDataOnExit"
      "--no-default-browser-check"
      "--incognito"
    ];
    dictionaries = [
      pkgs.hunspellDictsChromium.en_US
      pkgs.hunspellDictsChromium.fr_FR
    ];
  };

  imports = [ ./firefox ];
}
