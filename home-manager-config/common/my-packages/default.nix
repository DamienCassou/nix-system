{ pkgs, ... }:

let
  co2-sensor = pkgs.callPackage ./co2-sensor { };
  lint-system = pkgs.callPackage ./lint-system { };
  make-token = pkgs.callPackage ./make-token { };
in
{
  nixpkgs.overlays = [ (_: _: { inherit co2-sensor lint-system; }) ];

  home.packages = [
    co2-sensor
    lint-system
    make-token
  ];
}
