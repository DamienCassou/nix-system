{
  pkgs,
  lib,
  config,
  ...
}:

{
  config.xdg.desktopEntries = {
    "co2Sensor" = {
      name = "co2Sensor";
      exec = "${lib.getExe pkgs.co2-sensor}";
      terminal = false;
    };

    rofi-bluetooth = {
      name = "Rofi bluetooth";
      exec = "${lib.getExe pkgs.rofi-bluetooth}";
      terminal = false;
    };

    rofi-vpn = {
      name = "Rofi VPN";
      exec = "${pkgs.rofi-vpn}/bin/rofi-vpn";
      terminal = false;
    };

    rofi-pulse-sink = {
      name = "Rofi Pulse sink";
      exec = "${pkgs.rofi-pulse-select}/bin/rofi-pulse-select sink";
      terminal = false;
    };

    rofi-pulse-source = {
      name = "Rofi Pulse source";
      exec = "${pkgs.rofi-pulse-select}/bin/rofi-pulse-select source";
      terminal = false;
    };

    suspend = {
      name = "Suspend laptop";
      exec = "systemctl suspend";
      terminal = false;
    };

    umlet = {
      name = "UMLet";
      exec = "${pkgs.umlet}/bin/umlet";
      icon = "${pkgs.umlet}/lib/img/umlet_logo.png";
      terminal = false;
    };

    # Hide "Emacs" shortcut so I only use "Emacs (client)"
    emacs = {
      name = "Emacs";
      noDisplay = true;
      exec = "emacs %F";
    };

    # Wrap into nixGLIntel
    "calibre-gui" = {
      name = "calibre";
      exec = "${pkgs.nixGLIntel}/bin/nixGLIntel ${pkgs.calibre}/bin/calibre --detach %U";
      icon = "calibre-gui";
    };

    # Wrap into nixGLIntel
    "firefox" = {
      name = "Firefox";
      exec = "${pkgs.nixGLIntel}/bin/nixGLIntel ${lib.getExe config.programs.firefox.finalPackage} --name firefox %U";
      icon = "firefox";
    };

    # Wrap into nixGLIntel
    "Mattermost" = {
      name = "Mattermost";
      exec = "${pkgs.nixGLIntel}/bin/nixGLIntel ${lib.getExe pkgs.mattermost-desktop} %U";
      icon = "${pkgs.mattermost-desktop}/share/mattermost-desktop/app_icon.png";
    };
  };
}
