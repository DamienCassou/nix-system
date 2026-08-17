{ pkgs, ... }:
{
  imports = [
    ../../../home-manager-config/common
    ../../../home-manager-config/forbidden-at-work.nix
    ../../../home-manager-config/linux
    ./gnome.nix
  ];

  home = {
    homeDirectory = "/Users/cassou";
    packages = with pkgs; [
      signal-desktop
      ungoogled-chromium
    ];
    username = "cassou";
  };
}
