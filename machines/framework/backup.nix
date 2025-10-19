{ config, pkgs, lib, ...}:

let
  homeManagerFiles = lib.mapAttrsToList (_: file: file) config.home.file;
  homeManagerSymlinks = (lib.filter (file: !file.recursive) homeManagerFiles);
  homeManagerRsyncExcludePatterns =
    map (file: ''  --exclude "${file.target}"'') homeManagerSymlinks;
  homeManagerRsyncExclude =
    lib.concatStringsSep " \\\n" homeManagerRsyncExcludePatterns;
  backup-rsync = pkgs.writeShellScriptBin "backup-rsync" ''
    cd ~
    exec rsync \
     --exclude "Documents/android/oneplus7t/sdcard" \
     ${homeManagerRsyncExclude} \
     --delete-excluded --delete --archive --progress  \
     ~/ \
     "$1"
  '';
  makeBackupScript = name: uuid: backupDir:
    pkgs.writeShellScriptBin "backup-${name}" ''
      # Use system's udisksctl instead of nixpkgs one because it
      # requires a system's service running:
      udisksctl unlock --block-device /dev/disk/by-uuid/${uuid}
      udisksctl mount --block-device /dev/mapper/luks-${uuid}
      ${lib.getExe backup-rsync} /run/media/cassou/${name}/${backupDir}/
      sync
      udisksctl unmount --block-device /dev/mapper/luks-${uuid}
      udisksctl lock --block-device /dev/disk/by-uuid/${uuid}
    '';
  backup-samsung = makeBackupScript "samsung" "132263e0-eb9b-4e9e-b111-7dd2713698fb" "rsync-jenny/cassou/";
in
{
  home.packages = [
    backup-samsung
  ];
}
