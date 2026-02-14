{ ... }:
{
  # Configure how to decrypt the USB external drive using a key file in /root/lacie.key
  # https://nixos.wiki/wiki/Full_Disk_Encryption#Option_2:_Unlock_after_boot_using_crypttab_and_a_keyfile
  environment.etc.crypttab = {
    mode = "0600";
    text = ''
      lacie UUID=285953dd-e9b7-4630-af11-40464cbf6640 /root/lacie.key
    '';
  };

  services.udev.extraRules = ''
    SUBSYSTEM=="block" ENV{ID_WWN}=="wwn-0x5000c5009cb628a1",\
    ENV{SYSTEMD_WANTS}="systemd-cryptsetup@lacie.service"
  '';

  fileSystems."/run/media/lacie" = {
    device = "/dev/mapper/lacie";
    fsType = "ext4";
    options = [
      "defaults"
      "noatime"
      "x-systemd.automount"
      "x-systemd.device-timeout=5"
      "noauto"
    ];
  };
}
