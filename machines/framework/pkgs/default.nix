self: super: {
  pass-show-password = self.pkgs.writeShellScriptBin "pass-show-password.sh" ''
    ${self.pkgs.pass}/bin/pass show "$@" | head -n 1 | head --byte=-1
  '';
}
