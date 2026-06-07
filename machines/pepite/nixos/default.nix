{ lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../../nixos-config
  ];

  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;

    initrd.luks.devices."luks-dc7720b7-9531-4a61-9cd3-ed4b1fc63111".device =
      "/dev/disk/by-uuid/dc7720b7-9531-4a61-9cd3-ed4b1fc63111";
  };

  networking = {
    hostName = "pepite";
  };

  i18n = lib.mkForce {
    defaultLocale = "fr_FR.UTF-8";

    extraLocaleSettings = {
      LC_ADDRESS = "fr_FR.UTF-8";
      LC_IDENTIFICATION = "fr_FR.UTF-8";
      LC_MEASUREMENT = "fr_FR.UTF-8";
      LC_MONETARY = "fr_FR.UTF-8";
      LC_NAME = "fr_FR.UTF-8";
      LC_NUMERIC = "fr_FR.UTF-8";
      LC_PAPER = "fr_FR.UTF-8";
      LC_TELEPHONE = "fr_FR.UTF-8";
      LC_TIME = "fr_FR.UTF-8";
    };
  };

  services = {
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    xserver = {
      enable = true;
      desktopManager.gnome.enable = true;
      displayManager.gdm.enable = true;

      xkb = lib.mkForce {
        layout = "us";
        variant = "intl";
      };
    };
  };

  # console.keyMap = "us-acentos";

  users = {
    users = {
      sarah = {
        isNormalUser = true;
        home = "/Users/sarah";

        # use mkpasswd to generate a hashedPassword:
        hashedPassword = "$y$j9T$eDPipTfmeL9gDhG4PCRUg1$lKetU63O6XfUPqYggN3m.DjcvIlapYC8btU3ClyFSo1";

        uid = 1001;
        description = "Sarah Cassou";
        extraGroups = [
          "audio"
          "cassou"
          "networkmanager"
        ];

        packages = with pkgs; [
          firefox
          libreoffice
          signal-desktop
        ];
      };
    };
  };

  system.stateVersion = "26.05";
}
