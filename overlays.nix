{
  lib,
  pkgs,
  system,
  emacs-overlay,
  firefox-addons,
  nixpkgs-firefox-darwin,
  nixpkgs-stable,
  ...
}:

[
  emacs-overlay.overlay
  nixpkgs-firefox-darwin.overlay
  (_: _: {
    firefox-addons = firefox-addons.packages.${system};
    stable = import nixpkgs-stable {
      inherit system;
      config.allowUnfree = true;
    };
  })
]
