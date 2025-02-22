{ config, ... }:

let
  home = config.home.homeDirectory;
in
"
*.qcow2
*.vdi
*~
*.elc
${home}/.cabal/store
${home}/.cache
${home}/.cargo
${home}/.ccache
${home}/.com.lunii.luniistore.loader.MainApp
${home}/.config/Cypress
${home}/.config/Element
${home}/.config/Microsoft/Microsoft Teams
${home}/.config/Signal
${home}/.config/Slack
${home}/.config/balena-etcher-electron
${home}/.config/chromium
${home}/.config/google-chrome
${home}/.config/karma-runner
${home}/.config/libvirt
${home}/.config/pulse
${home}/.config/teams-for-linux
${home}/.config/skypeforlinux
${home}/.config/syncthing/*.db
${home}/.config/teams
${home}/.dotnet
${home}/.emacs.d/.cask
${home}/.gksu.lock
${home}/.gnupg/random_seed
${home}/.local/jetbrains-rider
${home}/.local/ruby/*/cache
${home}/.local/share/Steam
${home}/.local/share/Trash
${home}/.local/share/containers
${home}/.local/share/dbus-1
${home}/.local/share/gnome-boxes
${home}/.local/share/go/pkg
${home}/.local/share/gvfs-metadata
${home}/.local/share/lutris
${home}/.local/share/mpd
${home}/.local/share/recently-used.xbel
${home}/.mozilla
${home}/.npm
${home}/.nuget
${home}/.var/app
${home}/.xsession-errors
${home}/*/Monitor.Web.Ui/logs
${home}/personal/android/pixel7a/synced/backups
${home}/Downloads
${config.accounts.email.maildirBasePath}/.notmuch/xapian
${config.accounts.email.maildirBasePath}/offlineimap-metadata
${home}/Library/Application Support
${home}/Library/Caches
${home}/Nextcloud
${home}/go
${home}/misc
${home}/tmp
"
