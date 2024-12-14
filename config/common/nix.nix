{
  config,
  lib,
  pkgs,
  ...
}:
{
  nix = {
    package = pkgs.nix;
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
