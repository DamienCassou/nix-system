{
  config,
  pkgs,
  lib,
  ...
}:

let
  homeManagerFiles = lib.mapAttrsToList (_: file: file) config.home.file;
  homeManagerSymlinks = lib.map (file: file.target) (
    lib.filter (file: !file.recursive) homeManagerFiles
  );
  personalExcludedFilenames = [
    "*.vdi"
    "**/node_modules/"
    "**/bin/Debug/"
    "**/bin/Release/"
    "/.Trash"
    "/OneDrive - Wolters Kluwer"
    "/java_error_in_rider.hprof"
    "/.cache"
    "/.config/.android/avd"
    "/.config/colima"
    "/.config/libvirt"
    "/.colima"
    "/.gradle/caches"
    "/.local/jetbrains-rider"
    "/.local/share/containers"
    "/.local/share/gnome-boxes"
    "/.local/share/libvirt/images"
    "/.local/share/NuGet/http-cache"
    "/.local/share/Trash"
    "/Library/Application Support/discord"
    "/Library/Application Support/Mattermost"
    "/Library/Application Support/Slack"
    "/Library/Application Support/Steam"
    "/Library/Caches/"
    "/Library/CloudStorage/"
    "/Library/Containers/com.docker.docker/Data"
    "/Library/Containers/com.microsoft.teams2/"
    "/personal/android/pixel7a/synced"
    "/tmp"
  ];
  excludePatterns = map (filename: ''--exclude "${filename}"'') (
    homeManagerSymlinks ++ personalExcludedFilenames
  );
  excludeString = lib.concatStringsSep " \\\n" excludePatterns;
  backup-rsync = pkgs.writeShellScriptBin "backup-rsync" ''
    cd ~
    exec rsync \
     ${excludeString} \
     --delete-excluded --delete --archive --progress --stats --ignore-errors --human-readable \
     ~/ \
     "$1"
  '';
in
{
  home.packages = [
    backup-rsync
  ];
}
