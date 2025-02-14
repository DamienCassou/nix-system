{ pkgs, ... }:
{
  imports = [
    ./desktop-entries.nix
  ];

  home = {
    packages = with pkgs; [
      arandr
      blueman
      brightnessctl
      dmidecode
      networkmanager # for nmcli
      pavucontrol
      pciutils
      pulseaudio
      rofi-bluetooth
      rofi-pulse-select
      xdg-utils
      xorg.xmodmap
      xorg.xrdb
      xorg.xset
    ];

  };

  programs.bash.shellAliases = {
    "dnf-list" = "dnf repoquery --list";
    "dnf-provides" = "dnf repoquery --cacheonly --file";
  };

  services = {
    poweralertd.enable = true;
    safeeyes.enable = true;

    snixembed = {
      enable = true;

      beforeUnits = [
        # https://github.com/slgobinath/SafeEyes/wiki/How-to-install-backend-for-Safe-Eyes-tray-icon
        "safeeyes.service"
      ];
    };

    systembus-notify.enable = true;
  };
}
