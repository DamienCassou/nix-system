{ pkgs, ... }:

let
  nix-index-database = (import
    ../../nix-index-database/packages.nix).${pkgs.stdenv.system}.database;
  packages.${pkgs.stdenv.system} = {
    nix-index-with-db =
      pkgs.callPackage ../../nix-index-database/nix-index-wrapper.nix {
        inherit nix-index-database;
      };
    comma-with-db =
      pkgs.callPackage ../../nix-index-database/comma-wrapper.nix {
        inherit nix-index-database;
      };
  };
  legacyPackages.${pkgs.stdenv.system}.database = nix-index-database;
in {
  imports = [
    ((import ../../nix-index-database/home-manager-module.nix) {
      inherit packages legacyPackages;
    })
  ];

  # Provides Bash's command-no-found and a nix-index command:
  programs.nix-index = { enableBashIntegration = true; };
  programs.nix-index-database.comma.enable = true;
}
