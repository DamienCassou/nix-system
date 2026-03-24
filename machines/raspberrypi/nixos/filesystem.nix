{ ... }:
{
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/NIXOS_SD";
      fsType = "ext4";
    };

    "/tmp".fsType = "tmpfs";
    "/var/log".fsType = "tmpfs";
  };
}
