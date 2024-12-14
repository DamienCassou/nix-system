{
  config,
  pkgs,
  lib,
  ...
}:

let
  borgmaticIcon = ./borgmatic.png;
  homeManagerFiles = lib.mapAttrsToList (_: file: file) config.home.file;
  homeManagerSymlinks = lib.filter (file: !file.recursive) homeManagerFiles;
  homeManagerRsyncExcludePatterns = map (file: ''--exclude "${file.target}"'') homeManagerSymlinks;
  homeManagerRsyncExclude = lib.concatStringsSep " \\\n" homeManagerRsyncExcludePatterns;
  backup-rsync = pkgs.writeShellScriptBin "backup-rsync" ''
    cd ~
    exec rsync \
     --exclude '*.vdi' \
     --exclude '**/node_modules/' \
     --exclude "/.cache" \
     --exclude "/.config/libvirt" \
     --exclude "/.local/jetbrains-rider" \
     --exclude "/.local/share/containers" \
     --exclude "/.local/share/gnome-boxes" \
     --exclude "/.local/share/libvirt/images" \
     --exclude "/.local/share/Trash" \
     --exclude "/personal/android/pixel7a/synced" \
     ${homeManagerRsyncExclude} \
     --delete-excluded --delete --archive --progress  \
     ~/ \
     "$1"
  '';
  makeBackupScript =
    name: uuid: backupDir:
    pkgs.writeShellScriptBin "backup-${name}" ''
      set -e

      function eject() {
        sync
        udisksctl unmount --block-device /dev/mapper/luks-${uuid}
        udisksctl lock --block-device /dev/disk/by-uuid/${uuid}
        udisksctl power-off --block-device /dev/disk/by-uuid/${uuid}
      }

      trap eject EXIT

      # Use system's udisksctl instead of nixpkgs one because it
      # requires a system's service running:
      udisksctl unlock --block-device /dev/disk/by-uuid/${uuid}
      udisksctl mount --block-device /dev/mapper/luks-${uuid}
      ${lib.getExe backup-rsync} /run/media/cassou/${name}/${backupDir}/
      backupStatusCode=$?

      sync

      if [[ $backupStatusCode -eq 0 ]]; then
        notify-send --icon=${borgmaticIcon} "Backup succeeded" "The backup to \"${name}\" succeeded"
      else
        notify-send --urgency=critical --icon=${borgmaticIcon} "Backup failed" "The backup to \"${name}\" failed"
      fi
    '';
  backup-lacie = makeBackupScript "lacie" "ec4f10e9-b690-4623-a054-ad7e13a43452" "rsync-damien";
in
{
  home.packages = [
    backup-rsync
    backup-lacie
  ];
}
