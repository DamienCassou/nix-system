{ pkgs, ... }:

let
  co2-sensor = pkgs.callPackage ./co2-sensor { };
  lint-system = pkgs.writeShellScriptBin "lint-system" ./lint-system.sh;
in
{
  imports = [ ./backup.nix ];

  nixpkgs.overlays = [ (_: _: { inherit co2-sensor lint-system; }) ];

  home.packages = [
    co2-sensor
    lint-system
  ];
}
