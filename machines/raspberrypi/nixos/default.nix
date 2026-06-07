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
      8384 # syncthing
    ];
  };

  system.stateVersion = "26.05";

  hardware = {
    enableRedistributableFirmware = true;
  };

  services = {
    mpd = {
      enable = true;
      musicDirectory = "/run/media/lacie/rsync-macbook/personal/music/son";
      openFirewall = true;
      playlistDirectory = "/run/media/lacie/rsync-macbook/personal/music/playlists";
      network = {
        listenAddress = "any";
      };
      startWhenNeeded = true;
      user = "cassou";
    };
  };
}
