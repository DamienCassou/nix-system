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

let
  my-scripts = import ./home-manager-config/common/my-scripts.nix { inherit lib pkgs; };
in
[
  emacs-overlay.overlay
  nixpkgs-firefox-darwin.overlay
  (_: _: {
    inherit my-scripts;
    firefox-addons = firefox-addons.packages.${system};
    stable = import nixpkgs-stable {
      inherit system;
      config.allowUnfree = true;
    };
  })
  (
    _: super:
    let
      emacs = super.emacs-unstable.override { withNativeCompilation = false; };
    in
    {
      inherit emacs;
      notmuch = pkgs.notmuch.override { inherit emacs; };
    }
  )
]
