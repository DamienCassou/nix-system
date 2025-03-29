{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    mpc_cli
  ];

  services = {
    mpd = {
      enable = true;
      musicDirectory = config.xdg.userDirs.music;
      playlistDirectory = config.xdg.userDirs.music + "../playlists";
    };
  };

  xdg = {
    userDirs = {
      music = "${config.home.homeDirectory}/personal/music/damien/";
    };
  };
}
