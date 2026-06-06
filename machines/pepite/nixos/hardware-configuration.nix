{
  config,
  lib,
  modulesPath,
  ...
}:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot = {
    initrd = {
      availableKernelModules = [
        "xhci_pci"
        "nvme"
        "usb_storage"
        "sd_mod"
      ];
      kernelModules = [ ];
    };

    extraModulePackages = [ ];
    initrd.luks.devices."luks-cc43cb9e-2f5b-4fbf-a123-0044c21df034".device =
      "/dev/disk/by-uuid/cc43cb9e-2f5b-4fbf-a123-0044c21df034";
    kernelModules = [ "kvm-intel" ];
  };

  fileSystems = {
    "/" = {
      device = "/dev/mapper/luks-cc43cb9e-2f5b-4fbf-a123-0044c21df034";
      fsType = "btrfs";
    };

    "/home" = {
      device = "/dev/mapper/luks-cc43cb9e-2f5b-4fbf-a123-0044c21df034";
      fsType = "btrfs";
      options = [ "subvol=home" ];
    };

    "/nix" = {
      device = "/dev/mapper/luks-cc43cb9e-2f5b-4fbf-a123-0044c21df034";
      fsType = "btrfs";
      options = [ "subvol=nix" ];
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/AE3C-5CBA";
      fsType = "vfat";
      options = [
        "fmask=0077"
        "dmask=0077"
      ];
    };

  };

  swapDevices = [
    { device = "/dev/mapper/luks-dc7720b7-9531-4a61-9cd3-ed4b1fc63111"; }
  ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
