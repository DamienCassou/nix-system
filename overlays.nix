{
  lib,
  pkgs,
  pkgs-unstable,
  system,
  emacs-overlay,
  firefox-addons,
  nixGL,
  nixpkgs-firefox-darwin,
  ...
}:

let
  my-scripts = import ./home-manager-config/common/my-scripts.nix { inherit lib pkgs; };
in
[
  nixGL.overlay
  emacs-overlay.overlays.package
  (_: _: {
    inherit my-scripts;
    firefox-addons = firefox-addons.packages.${system};
  })
]
++ (lib.optionals pkgs.stdenv.hostPlatform.isDarwin [
  nixpkgs-firefox-darwin.overlay
])
++ [
  (
    _: super:
    let
      emacs = pkgs-unstable.emacs31;
    in
    {
      inherit emacs;
      notmuch = pkgs.notmuch.override { inherit emacs; };
    }
  )
]
++ [
  (_: super: {
    # Workaround for https://github.com/NixOS/nixpkgs/issues/507531
    direnv = super.direnv.overrideAttrs (_: {
      doCheck = false;
    });
    pimsync = super.pimsync.overrideAttrs (_: {
      doCheck = false;
    });
  })
]
