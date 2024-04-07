# Notes for a new non-NixOS install:
# - localectl set-x11-keymap us pc105 colemak ctrl:nocaps
# - Deactivate SELINUX
# - hostnamectl set-hostname luz5
# - sudo usermod --append --groups dialout,docker,wheel,wireshark,vboxusers,adbusers cassou
# - Install nix in multi-user mode: https://nixos.org/manual/nix/stable/#sect-multi-user-installation
# - Install home-manager: https://github.com/nix-community/home-manager/blob/master/README.md
# - home-manager -f config/non-nixos.nix -I nixpkgs=nixpkgs/ -I home-manager=home-manager/ -b bak1 switch
# - dnf install lightdm lightdm-gtk i3lock swaylock NetworkManager-strongswan
# - systemctl disable gdm
# - systemctl enable lightdm
# - cp ./i3.desktop /usr/share/xsessions/default.desktop
# - cp ./sway.desktop to /usr/share/wayland-sessions
# - reboot
# - in lightdm, choose the "Default Xsession" session from the menu in the top bar
# - install i3lock # https://github.com/i3/i3lock/issues/286
# - install mono # https://www.mono-project.com/download/preview/
#     dnf install mono-devel mono-complete xsp referenceassemblies-pcl msbuild
# - install docker (https://docs.docker.com/engine/install/fedora/#install-using-the-repository)
# - Allow docker to access port 5000 (rider): sudo ufw allow in from any to 172.17.0.1/24 port 5000
# - Add "127.0.0.1  database.ftgp" and "127.0.0.1   rabbitmq" à /etc/hosts
{
  config,
  pkgs,
  lib,
  ...
}:
let
  # Only the en-US.UTF8 locale:
  locales = pkgs.glibcLocales.override { allLocales = false; };
in
{
  systemd.user.systemctlPath = "/usr/bin/systemctl";

  targets.genericLinux.enable = true;

  home.sessionVariables = {
    # https://nixos.org/nixpkgs/manual/#locales
    NIX_PATH = "/home/cassou/Documents/projects/nix-system";
  };

  pam.sessionVariables = {
    NIX_PATH = "/home/cassou/Documents/projects/nix-system";
  };

  systemd.user.sessionVariables.NIX_PATH = lib.mkForce "/home/cassou/Documents/projects/nix-system";

  home.sessionVariablesExtra = ''
    export INFOPATH="/usr/share/info:${config.home.profileDirectory}/share/info:''${INFOPATH}"
    export NIX_PATH="/home/cassou/Documents/projects/nix-system"
  '';

  xsession.profileExtra = ''
    export NIX_PATH="/home/cassou/Documents/projects/nix-system"
  '';

  xsession.initExtra = ''
    export NIX_PATH="/home/cassou/Documents/projects/nix-system"
  '';

  imports = [ ./home-manager ];
}
