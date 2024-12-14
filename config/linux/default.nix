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

  systemd.user = {
    # Automatically start new services and stop old ones:
    startServices = true;
  };
}
