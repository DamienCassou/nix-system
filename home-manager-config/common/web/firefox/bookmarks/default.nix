{ pkgs, ... }:
{
  bookmarks = {
    force = true;
    settings = [
      {
        name = "Startup Bookmarks";
        inherit ((pkgs.callPackage ./startup.nix { })) bookmarks;
      }
      {
        name = "Bookmarks Toolbar";
        toolbar = true;
        inherit ((pkgs.callPackage ./toolbar.nix { })) bookmarks;
      }
      {
        name = "Nix";
        inherit ((pkgs.callPackage ./nix.nix { })) bookmarks;
      }
    ]
    ++ (pkgs.callPackage ./normal.nix { }).bookmarks;
  };
}
