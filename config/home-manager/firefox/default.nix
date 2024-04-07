{ pkgs, ... }:

let profileName = "home-manager";
in {
  programs.firefox = {
    enable = true;
    policies = (pkgs.callPackage ./policies.nix { }).policies;
    profiles = {
      ${profileName} = {
        id = 0;
        isDefault = true;
        bookmarks = (pkgs.callPackage ./bookmarks { }).bookmarks;
        containers = (pkgs.callPackage ./containers.nix { }).containers;
        containersForce = true;
        extensions = (pkgs.callPackage ./extensions.nix { }).extensions;
        search = (pkgs.callPackage ./search.nix { }).search;
        settings = (pkgs.callPackage ./settings.nix { }).settings;
      };
    };
  };

  stylix.targets.firefox.profileNames = [ profileName ];
}
