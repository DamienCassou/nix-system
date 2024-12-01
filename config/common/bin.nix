{ pkgs, ... }:
let
  my-scripts = pkgs.runCommandLocal "my-scripts" { } ''
    for script in ${./bin}"/"*; do
      install -D -m755 $script $out/bin/$(basename $script)
    done

    patchShebangs $out/bin
  '';
in
{
  home.packages = [ my-scripts ];
  nixpkgs.overlays = [ (_: _: { inherit my-scripts; }) ];
}
