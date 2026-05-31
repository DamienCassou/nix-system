{ pkgs, ... }:
{
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

    stateVersion = "26.05";
    username = "cassou";
  };

  programs.home-manager.enable = true;
}
