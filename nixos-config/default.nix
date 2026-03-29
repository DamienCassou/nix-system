{ ... }:
{
  console.useXkbConfig = true; # use xkb setup in tty.

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

  networking = {
    networkmanager.enable = true;
  };

  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      trusted-users = [ "@wheel" ];
    };
  };

  services = {
    openssh.enable = true;

    xserver.xkb = {
      layout = "us";
      variant = "colemak";
    };
  };

  time.timeZone = "Europe/Paris";

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
}
