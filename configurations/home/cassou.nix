# See /modules/home/* for actual settings
# This file is just *top-level* configuration.
{ flake, ... }:
let
  inherit (flake) inputs;
  inherit (inputs) self;
in
{
  imports = [
    self.homeModules.common
    self.homeModules.darwin
  ];

  home.stateVersion = "24.11";
}
