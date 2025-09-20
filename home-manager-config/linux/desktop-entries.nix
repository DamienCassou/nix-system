{ pkgs, lib, ... }:

{
  config.xdg.desktopEntries = {
    rofi-bluetooth = {
      name = "Rofi bluetooth";
      exec = "${lib.getExe pkgs.rofi-bluetooth}";
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
  };
}
