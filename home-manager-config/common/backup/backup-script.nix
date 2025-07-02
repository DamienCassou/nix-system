{
  config,
  pkgs,
  lib,
  ...
}:

let
  homeManagerFiles = lib.mapAttrsToList (_: file: file) config.home.file;
  homeManagerSymlinks = lib.filter (file: !file.recursive) homeManagerFiles;
  homeManagerRsyncExcludePatterns = map (file: ''--exclude "${file.target}"'') homeManagerSymlinks;
  homeManagerRsyncExclude = lib.concatStringsSep " \\\n" homeManagerRsyncExcludePatterns;
  backup-rsync = pkgs.writeShellScriptBin "backup-rsync" ''
    cd ~
    exec rsync \
     --exclude '*.vdi' \
     --exclude '**/node_modules/' \
     --exclude '**/bin/Debug/' \
     --exclude '**/bin/Release/' \
     --exclude "/.Trash" \
     --exclude "/OneDrive - Wolters Kluwer" \
     --exclude "/java_error_in_rider.hprof" \
     --exclude "/.cache" \
     --exclude "/.config/colima" \
     --exclude "/.config/libvirt" \
     --exclude "/.colima" \
     --exclude "/.local/jetbrains-rider" \
     --exclude "/.local/share/containers" \
     --exclude "/.local/share/gnome-boxes" \
     --exclude "/.local/share/libvirt/images" \
     --exclude "/.local/share/Trash" \
     --exclude "/Library/Application Support/discord" \
     --exclude "/Library/Application Support/Slack" \
     --exclude "/Library/Caches/Homebrew" \
     --exclude "/Library/Containers/com.docker.docker/Data" \
     --exclude "/Library/Containers/com.microsoft.teams2/" \
     --exclude "/personal/android/pixel7a/synced" \
     --exclude "/tmp" \
     ${homeManagerRsyncExclude} \
     --delete-excluded --delete --archive --progress --stats \
     ~/ \
     "$1"
  '';
in
{
  home.packages = [
    backup-rsync
  ];
}
