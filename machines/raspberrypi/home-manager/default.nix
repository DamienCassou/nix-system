{ ... }:
{
  imports = [
    ../../../home-manager-config/common/syncthing.nix
    ../../../secrets/syncthing/raspberrypi
  ];

  home = {
    enableNixpkgsReleaseCheck = false;
    homeDirectory = "/Users/cassou";

    keyboard = {
      layout = "us";
      variant = "colemak";
      options = [ "ctrl:nocaps" ];
    };

    stateVersion = "25.11";
    username = "cassou";
  };

  programs.home-manager.enable = true;

  services = {
    mpd = {
      enable = true;
      musicDirectory = "/run/media/lacie/rsync-macbook/personal/music/son";
      playlistDirectory = "/run/media/lacie/rsync-macbook/personal/music/playlists";
      network = {
        listenAddress = "any";
      };
    };

    syncthing = {
      guiAddress = "0.0.0.0:8384";
      passwordFile = ../../../secrets/syncthing/raspberrypi/password;
    };
  };

}
