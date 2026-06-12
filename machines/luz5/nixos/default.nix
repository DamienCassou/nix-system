{ ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../../nixos-config
  ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  networking = {
    hostName = "luz5";
  };

  programs = {
    steam.enable = true;
  };

  services = {
    desktopManager.gnome.enable = true;
    displayManager.gdm.enable = true;
    gnome.gcr-ssh-agent.enable = false;

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    printing.enable = true;
    pulseaudio.enable = false;
    xserver.enable = true;
  };

  console = {
    earlySetup = true;
  };

  system.stateVersion = "26.05";

  hardware = {
    nitrokey.enable = true;
    gpgSmartcards.enable = true;
  };
}
