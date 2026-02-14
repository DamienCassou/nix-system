{ lib, ... }:

{
  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "usbhid"
  ];

  boot.initrd.kernelModules = [ ];

  boot.loader = {
    grub.enable = false;
    generic-extlinux-compatible.enable = true;
  };

  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];

  boot.kernelParams = [
    "snd_bcm2835.enable_hdmi=1"
    "snd_bcm2835.enable_headphones=1"
  ];

  fileSystems."/" = {
    device = "/dev/disk/by-label/NIXOS_SD";
    fsType = "ext4";
  };

  swapDevices = [ ];

  nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";
}
