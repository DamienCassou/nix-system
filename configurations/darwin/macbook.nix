# See /modules/darwin/* for actual settings
# This file is just *top-level* configuration.
{ flake, ... }:

let
  inherit (flake) inputs;
  inherit (inputs) self;
in
{
  imports = [
    self.darwinModules.default
  ];

  home-manager.backupFileExtension = "nixos-unified-template-backup";

  nixpkgs.hostPlatform = "aarch64-darwin";
  networking.hostName = "macbook";

  system = {
    primaryUser = "cassou";
    stateVersion = 6;
  };
}
