{ pkgs, lib, ... }:

let
  nodejs = pkgs.nodejs_20;
  # Adding libuuid to some node binaries are required by the
  # "node-canvas" package (used by webdriver.io for visual testing for
  # example)
  wrapWithMissingLibraries =
    binaryFile:
    pkgs.writeShellScriptBin (baseNameOf binaryFile) ''
      LD_LIBRARY_PATH="${pkgs.lib.makeLibraryPath [ pkgs.libuuid ]}";
      export LD_LIBRARY_PATH
      exec ${binaryFile} "$@";
    '';
  node = wrapWithMissingLibraries (lib.getExe nodejs);
  yarn = wrapWithMissingLibraries (lib.getExe pkgs.yarn);
in
{
  imports = [
    ./bash.nix
    ./emacs.nix
    ./git.nix
    ./gpg.nix
    ./ssh.nix
  ];

  programs.bun = {
    enable = true;
  };

  home.packages = [
    node
    yarn
  ] ++ (with pkgs; [ jwt-cli ]);
}
