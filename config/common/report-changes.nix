{ config, ... }:

{
  home.activation.report-changes = config.lib.dag.entryAnywhere ''
    if [[ -v oldGenPath ]]; then
      run nix store diff-closures $oldGenPath $newGenPath
    fi
  '';
}
