{ ... }:
{
  imports = [
    ../../home-manager-config/common/syncthing.nix
    ../../secrets/syncthing/raspberrypi
  ];

  home = {
    enableNixpkgsReleaseCheck = false;
    homeDirectory = "/home/cassou";

    keyboard = {
      layout = "us";
      variant = "colemak";
      options = [ "ctrl:nocaps" ];
    };

    stateVersion = "25.05";
    username = "cassou";
  };

  programs.home-manager.enable = true;
}
