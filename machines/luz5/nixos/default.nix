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

  services.xserver.enable = true;

  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  services.gnome.gcr-ssh-agent.enable = false;

  console = {
    earlySetup = true;
  };

  services.printing.enable = true;

  services.pulseaudio.enable = false;

  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  system.stateVersion = "25.11";

  hardware = {
    nitrokey.enable = true;
    gpgSmartcards.enable = true;
  };
}
