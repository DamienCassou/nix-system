{ ... }:

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
      6600 # mpd
      8384 # syncthing
    ];
  };

  security.rtkit.enable = true;

  system.stateVersion = "25.11";

  hardware = {
    enableRedistributableFirmware = true;
  };
}
