{ pkgs, ... }:
{
  home.packages = [
    (pkgs.runCommandLocal "my-scripts" { } ''
      for script in ${./bin}"/"*; do
        install -D -m755 $script $out/bin/$(basename $script)
      done

      patchShebangs $out/bin
    '')
  ];
}
