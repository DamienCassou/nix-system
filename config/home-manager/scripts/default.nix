{ pkgs, ... }:

let
  co2Sensor = pkgs.callPackage ./co2-sensor { };
  lint-system = pkgs.writeShellScriptBin "lint-system" ./lint-system.sh;
  nixpkgs-review = pkgs.writeShellScriptBin "nixpkgs-review" ''${./nixpkgs-review.sh} "$@"'';
  pass-show-password = pkgs.writeShellScriptBin "pass-show-password" ''
    ${pkgs.pass}/bin/pass show "$@" | head -n 1 | head --byte=-1
  '';
in
{
  imports = [ ./backup.nix ];

  nixpkgs.overlays = [ (self: super: { inherit co2Sensor pass-show-password lint-system; }) ];

  home.packages = [
    co2Sensor
    lint-system
    nixpkgs-review
    pass-show-password
  ];
}
