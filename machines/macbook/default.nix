{ config, pkgs, ... }:

let
  home = config.home.homeDirectory;
in
{
  imports = [
    ../../home-manager-config/common
    ../../home-manager-config/darwin
    ../../secrets/syncthing/macbook
  ];

  programs.firefox.profiles.home-manager.bookmarks.settings = [
    {
      name = "Bookmarks Toolbar";
      toolbar = true;
      inherit ((pkgs.callPackage ./firefox-toolbar.nix { })) bookmarks;
    }
  ];

  programs.git.maintenance.repositories = [
    "${home}/work/setup/monitor"
  ];
}
