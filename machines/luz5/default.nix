{ pkgs, ... }:
{
  imports = [
    ../../home-manager-config/common
    ../../home-manager-config/forbidden-at-work.nix
    ../../home-manager-config/non-nixos-linux.nix
    ../../home-manager-config/linux
    ../../secrets/syncthing/luz5
  ];

  home = {
    homeDirectory = "/home/cassou";
    username = "cassou";
  };

  nixGL = {
    packages = pkgs.nixgl;
    installScripts = [ "mesa" ];
  };
}
