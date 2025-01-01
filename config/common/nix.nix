{
  config,
  lib,
  pkgs,
  ...
}:
let
  # Issue: https://github.com/NixOS/nix/issues/9708
  nix = pkgs.nixVersions.nix_2_24.overrideAttrs (old: rec {
    version = "2.24.10";
    src = pkgs.fetchFromGitHub {
      owner = "NixOS";
      repo = "nix";
      rev = version;
      hash = "sha256-XdeVy1/d6DEIYb3nOA6JIYF4fwMKNxtwJMgT3pHi+ko=";
    };
  });
in
{
  home.packages = with pkgs; [
    cachix
    nil # LSP server for Nix
    niv
    nix
    nixfmt-rfc-style
    nixpkgs-fmt # nix formatter for nixpkgs code base
    nodePackages.node2nix
  ];

  nix = {
    package = nix;
    nixPath = [ "${config.home.homeDirectory}/personal/nix-system" ];
    channels = { };
    keepOldNixPath = false;
    settings = {
      experimental-features = [
        "flakes"
        "nix-command"
      ];
      substituters = [
        "https://cache.nixos.org"
        "https://devenv.cachix.org"
        "https://emacs-ci.cachix.org"
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
        "emacs-ci.cachix.org-1:B5FVOrxhXXrOL0S+tQ7USrhjMT5iOPH+QN9q0NItom4="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
    registry = {
      "flakes" = {
        from = {
          id = "nixpkgs";
          type = "indirect";
        };
        to = {
          path = "${lib.elemAt config.nix.nixPath 0}/nixpkgs";
          type = "path";
        };
      };
    };
  };
}
