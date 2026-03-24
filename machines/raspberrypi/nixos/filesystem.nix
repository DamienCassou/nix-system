{ ... }:
{
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/NIXOS_SD";
      fsType = "ext4";
      options = [ "commit=1000" ];
    };

    "/tmp".fsType = "tmpfs";
    "/var/log".fsType = "tmpfs";
  };
}
