{flake, ...}:
let
  inherit (flake) inputs;
  inherit (inputs) self;
  packages = self + /packages;
in
  final: prev: {
    stable = import inputs.nixpkgs-stable {
      inherit system;
      config.allowUnfree = true;
    }
  }
