{ config, ... }:

let
  home = config.home.homeDirectory;
in
{
  imports = [
    ../../home-manager-config/common
    ../../home-manager-config/darwin
    ../../secrets/syncthing/macbook
  ];

  programs.git.maintenance.repositories = [
    "${home}/work/setup/monitor"
  ];
}
