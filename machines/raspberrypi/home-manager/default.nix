{ pkgs, ... }:
{
  imports = [
    ../../../home-manager-config/common/syncthing.nix
    ../../../secrets/syncthing/raspberrypi
  ];

  home = {
    enableNixpkgsReleaseCheck = false;
    homeDirectory = "/Users/cassou";

    keyboard = {
      layout = "us";
      variant = "colemak";
      options = [ "ctrl:nocaps" ];
    };

    packages = with pkgs; [
      git
      ncdu
    ];

    stateVersion = "25.11";
    username = "cassou";
  };

  programs.home-manager.enable = true;

  services = {
    syncthing = {
      guiAddress = "0.0.0.0:8384";
    };
  };
}
