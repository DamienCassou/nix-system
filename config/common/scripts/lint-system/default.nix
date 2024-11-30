{ pkgs, ... }:

(pkgs.runCommandLocal "lint-system" { } ''
  install -D -m755 ${./lint-system.sh} $out/bin/lint-system
  patchShebangs $out/bin

  for module in ${./modules}"/"*; do
    install -D -m755 $module $out/share/lint-system/$(basename $module)
  done

  substituteInPlace $out/bin/lint-system \
    --subst-var-by modules $out/share/lint-system

'')
