{ pkgs, ... }:
{
  home.packages = with pkgs; [
    tor-browser
    transmission_4-gtk
  ];
}
