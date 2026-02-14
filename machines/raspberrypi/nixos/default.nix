{ ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./lacie.nix
  ];

  networking = {
    hostName = "raspberrypi";
    firewall.allowedTCPPorts = [
      6600 # mpd
      8384 # syncthing
    ];
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

  services.xserver.xkb = {
    layout = "us";
    variant = "colemak";
  };

  console.useXkbConfig = true; # use xkb setup in tty.

  services.pulseaudio.enable = false;

  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  users = {
    mutableUsers = false;
    groups.cassou = {
      gid = 1000;
    };
    users.cassou = {
      isNormalUser = true;
      home = "/Users/cassou";

      # use mkpasswd to generate a hashedPassword:
      hashedPassword = "$y$j9T$vcwc29rDt948CahE25xKu.$bc12.AHRsexSlhjMIU9WEuOIQXlJdkwBY1mxaPPquf.";

      uid = 1000;
      description = "Damien Cassou";
      extraGroups = [
        "audio"
        "cassou"
        "networkmanager"
        "wheel"
      ];
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPNt/RcAiO+zgCvPUBXGHwPRr1qpufb/+tZlSab5D0cM cardno:000F_956772F4"
      ];
    };
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
    enableRedistributableFirmware = true;
  };
}
