{
  config,
  pkgs,
  lib,
  ...
}:

{
  home.activation.report-changes = config.lib.dag.entryAnywhere ''
    run ${lib.getExe pkgs.nix} store diff-closures $oldGenPath $newGenPath
  '';
}
