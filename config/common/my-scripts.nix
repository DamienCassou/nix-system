{ lib, pkgs, ... }:
let
  my-scripts = pkgs.runCommandLocal "my-scripts" { } ''
    for script in ${./my-scripts}"/"*; do
      install -D -m755 $script $out/bin/$(basename $script)
    done

    substituteInPlace $out/bin/nixpkgs-review.sh \
      --subst-var-by nixpkgs-review ${lib.getExe pkgs.nixpkgs-review}

    substituteInPlace $out/bin/pass-show-password \
      --subst-var-by path ${
        lib.makeBinPath (
          with pkgs;
          [
            coreutils
            pass
          ]
        )
      }

    patchShebangs $out/bin
  '';
in
{
  home.packages = [ my-scripts ];
  nixpkgs.overlays = [ (_: _: { inherit my-scripts; }) ];
}
