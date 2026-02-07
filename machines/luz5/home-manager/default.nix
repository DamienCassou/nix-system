{ pkgs, ... }:
{
  imports = [
    ../../../home-manager-config/common
    ../../../home-manager-config/forbidden-at-work.nix
    ../../../home-manager-config/linux
    ../../../secrets/syncthing/luz5
    ./gnome.nix
  ];

  home = {
    homeDirectory = "/home/cassou";
    packages = with pkgs; [ signal-desktop ];
    username = "cassou";
  };
}
