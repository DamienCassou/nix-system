{ pkgs, ... }:

let
  # https://discourse.nixos.org/t/opening-i3-from-home-manager-automatically/4849/8
  homeManagerXSessionPath = ".hm-xsession";
in
{
  ###########################
  # Hardware
  ###########################

  hardware.enableRedistributableFirmware = true;

  boot.initrd.availableKernelModules =
    [ "xhci_pci" "nvme" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;

  services.fwupd.enable = true;

  services.xserver = {
    deviceSection = ''
      Option      "AccelMethod"  "sna"
    '';
  };

  hardware.trackpoint = {
    enable = true;
    emulateWheel = true;
    sensitivity = 200;
    speed = 255;
  };

  boot.initrd.luks.devices."nixos".device =
    "/dev/disk/by-uuid/13ed8356-3f11-4e90-afa6-a38357cfa549";
  boot.initrd.luks.devices."home".device =
    "/dev/disk/by-uuid/c1b3bba0-6621-4d90-b79c-476617ed3310";

  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    fsType = "ext4";
    options = [ "noatime" "nodiratime" ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-label/boot";
    fsType = "vfat";
    options = [ "noatime" "nodiratime" ];
  };

  fileSystems."/home" = {
    device = "/dev/mapper/home";
    fsType = "ext4";
    options = [ "noatime" "nodiratime" ];
  };

  swapDevices = [ ];

  boot.cleanTmpDir = true;

  ###########################
  # Users
  ###########################

  users.users.cassou = {
    name = "cassou";
    description = "Damien Cassou";
    uid = 1000;
    isNormalUser = true;
    createHome = false;
    shell = pkgs.bash;
    extraGroups =
      [ "wheel" "networkmanager" "adbusers" "libvirtd" "vboxusers" "docker" ];
  };

  ###########################
  # Keyboard
  ###########################

  services.xserver = {
    layout = "us";
    xkbVariant = "colemak";
    xkbOptions = "ctrl:nocaps";
  };

  console = { keyMap = "colemak"; };

  ###########################
  # Network
  ###########################

  # opennic servers:
  networking.nameservers = [ "51.15.98.97" "193.183.98.66" "151.80.222.79" ];
  networking.hostName = "luz5";

  services.openssh = {
    enable = true;
    passwordAuthentication = false;
    permitRootLogin = "no";
  };

  # For guests to connect to the host:
  networking.firewall.interfaces.virbr0.allowedTCPPorts = [ 22 ];

  networking.networkmanager.enable = false;
  networking.wireless = {
    enable = true;
    userControlled.enable = true;

    # Generate configuration of access points with
    # generate-wpa-supplicant-conf.sh > ~/Documents/projects/nix-system/secrets/wifi-access-points.nix
    networks = import ../secrets/wifi-access-points.nix;
  };

  ###########################
  # Sound
  ###########################

  sound.enable = true;

  hardware.pulseaudio = {
    enable = true;
    # NixOS allows either a lightweight build (default) or full build of
    # PulseAudio to be installed.  Only the full build has Bluetooth support, so
    # it must be selected here.
    package = pkgs.pulseaudioFull;
  };

  ###########################
  # Bluetooth
  ###########################

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  ###########################
  # Printers
  ###########################

  services.printing = {
    enable = true;
    drivers = with pkgs; [ hplip ];
  };

  programs.system-config-printer.enable = true;

  ###########################
  # Home-manager service
  ###########################

  programs.dconf.enable = true;

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  home-manager.users.cassou = { pkgs, ... }: {
    imports = [ ./home-manager ];

    xsession.scriptPath = homeManagerXSessionPath;

    home.packages = with pkgs; [
      # Software that are better packaged in other distributions than
      # in Nixpkgs so home-manager should only install them in NixOS:
      jetbrains.rider
      mono6
      dotnetCorePackages.sdk_3_1
      # Software that don't work if they are installed on non-NixOS
      # systems:
      i3lock # https://github.com/i3/i3lock/issues/286
      gnome-boxes
      mednafen # sound problem
    ];
  };

  ###########################
  # Nix
  ###########################

  nix = {
    nixPath = [
      "home-manager=${builtins.toString ../home-manager}"
      "nixos-hardware=${builtins.toString ../nixos-hardware}"
      "nixos-config=${builtins.toString ./nixos.nix}"

      # Configure NIX_PATH so it searches <nixpkgs> in my clone of the
      # git repository. For this to work fine, it's better to remove
      # all channels:
      #
      # $ nix-channel --list       # should print nothing
      # $ sudo nix-channel --list  # should print nothing
      #
      # Remove channels with:
      # $ nix-channel --remove
      "nixpkgs=${builtins.toString ../nixpkgs}"
    ];

    buildCores = 0;
  };

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.unison.enableX11 = false;

  ###########################
  # Graphical environment
  ###########################

  services.xserver = {
    enable = true;
    displayManager = {
      lightdm = {
        enable = true;
        greeters.gtk = {
          enable = true;
          cursorTheme = {
            name = "Adwaita";
            package = pkgs.gnome3.adwaita-icon-theme;
          };
        };
      };
      defaultSession = "none+i3";
    };

    windowManager.i3 = {
      enable = true;
      extraSessionCommands = "source ~/.profile";
    };
  };

  ###########################
  # Locate
  ###########################

  services.locate = {
    enable = true;
    locate = pkgs.mlocate;
    localuser = null;
    interval = "hourly";
    # same as the default except we include /nix/store:
    prunePaths =
      [ "/tmp" "/var/tmp" "/var/cache" "/var/lock" "/var/run" "/var/spool" ];
  };

  ###########################
  # Virtualisation
  ###########################

  virtualisation.docker.enable = true;

  virtualisation.libvirtd.enable = true;

  environment.systemPackages = with pkgs; [ ];

  ###########################
  # Misc
  ###########################

  documentation.man.generateCaches = true;

  time.timeZone = "Europe/Paris";

  services.ntp.enable = true;

  # Suspend even when an external screen is connected:
  services.logind.lidSwitchDocked = "suspend";

  services.throttled.enable = false;

  # To use the smart card mode (CCID) of the USB token:
  services.pcscd.enable = true;

  imports = [
    ./nixos
    <nixos-hardware/lenovo/thinkpad/t490>
    <home-manager/nixos>
  ];
}
