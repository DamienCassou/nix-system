{ ... }:

{
  imports = [ ./hardware-configuration.nix ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  networking = {
    hostName = "luz5";
    networkmanager.enable = true;
  };

  time.timeZone = "Europe/Paris";

  i18n = {
    defaultLocale = "en_US.UTF-8";

    extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };
  };

  services.xserver.enable = true;

  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  services.gnome.gcr-ssh-agent.enable = false;

  services.xserver.xkb = {
    layout = "us";
    variant = "colemak";
  };

  console = {
    earlySetup = true;
    useXkbConfig = true;
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

  users.users.cassou = {
    isNormalUser = true;
    description = "Damien Cassou";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    trusted-users = [ "@wheel" ];
  };

  services.openssh.enable = true;

  system.stateVersion = "25.11";

  hardware = {
    nitrokey.enable = true;
    gpgSmartcards.enable = true;
  };
}
