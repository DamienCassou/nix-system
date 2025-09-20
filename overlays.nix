{
  lib,
  pkgs,
  system,
  emacs-overlay,
  emacs-darwin,
  firefox-addons,
  nixpkgs-firefox-darwin,
  nixpkgs-stable,
  ...
}:

let
  my-scripts = import ./home-manager-config/common/my-scripts.nix { inherit lib pkgs; };
in
[
  emacs-overlay.overlays.package
  (_: _: {
    inherit my-scripts;
    firefox-addons = firefox-addons.packages.${system};
    stable = import nixpkgs-stable {
      inherit system;
      config.allowUnfree = true;
    };
  })
]
++ (lib.optionals pkgs.stdenv.hostPlatform.isDarwin [
  nixpkgs-firefox-darwin.overlay
  emacs-darwin.overlays.emacs
])
++ [
  (
    _: super:
    let
      emacs = super.emacs-30;
    in
    {
      inherit emacs;
      notmuch = pkgs.notmuch.override { inherit emacs; };
    }
  )
]
