{ pkgs, pkgs-unstable, ... }:

let
  profileName = "home-manager";
in
{
  programs.firefox = {
    enable = true;
    package = pkgs-unstable.firefox; # remove this line when switching to stateVersion=26.11
    languagePacks = [
      "en-US"
      "fr-FR"
    ];
    inherit ((pkgs.callPackage ./policies.nix { })) policies;
    profiles = {
      ${profileName} = {
        id = 0;
        isDefault = true;
        inherit ((pkgs.callPackage ./bookmarks { })) bookmarks;
        inherit ((pkgs.callPackage ./containers.nix { })) containers;
        containersForce = true;
        inherit ((pkgs.callPackage ./extensions.nix { })) extensions;
        inherit ((pkgs.callPackage ./search.nix { })) search;
        inherit ((pkgs.callPackage ./settings.nix { })) settings;
      };
    };
  };
}
