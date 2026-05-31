{ config, ... }:

{
  imports = [
    ./filesystem.nix
    ./hardware-configuration.nix
    ./lacie.nix
    ../../../nixos-config
    ../../../secrets/syncthing/raspberrypi
  ];

  networking = {
    hostName = "raspberrypi";
    firewall.allowedTCPPorts = [
      config.services.mpd.network.port
      8384 # syncthing
    ];
  };

  security.rtkit.enable = true;

  system.stateVersion = "26.05";

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
  };
}
