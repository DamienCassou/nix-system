{ ... }:

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
      openFirewall = true;
      settings = {
        bind_to_address = "any";
        music_directory = "/run/media/lacie/rsync-macbook/personal/music/son";
        playlist_directory = "/run/media/lacie/rsync-macbook/personal/music/playlists";
      };
      startWhenNeeded = true;
      user = "cassou";
    };
  };
}
