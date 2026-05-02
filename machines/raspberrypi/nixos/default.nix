{ config, ... }:

{
  imports = [
    ./filesystem.nix
    ./hardware-configuration.nix
    ./lacie.nix
    ../../../nixos-config
  ];

  networking = {
    hostName = "raspberrypi";
    firewall.allowedTCPPorts = [
      config.services.mpd.network.port
      8384 # syncthing
    ];
  };

  security.rtkit.enable = true;

  system.stateVersion = "25.11";

  hardware = {
    enableRedistributableFirmware = true;
  };

  services = {
    mpd = {
      enable = true;
      musicDirectory = "/run/media/lacie/rsync-macbook/personal/music/son";
      playlistDirectory = "/run/media/lacie/rsync-macbook/personal/music/playlists";
      network = {
        listenAddress = "any";
      };
      startWhenNeeded = true;
      user = "cassou";
    };

    syncthing = {
      guiAddress = "0.0.0.0:8384";
    };
  };
}
