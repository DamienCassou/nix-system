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

    stateVersion = "25.11";
    username = "cassou";
  };

  programs.home-manager.enable = true;
}
