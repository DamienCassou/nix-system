{ pkgs, ... }: {
  bookmarks = [
    {
      name = "Startup Bookmarks";
      inherit ((pkgs.callPackage ./startup.nix { })) bookmarks;
    }
    {
      name = "Bookmarks Toolbar";
      toolbar = true;
      inherit ((pkgs.callPackage ./toolbar.nix { })) bookmarks;
    }
  ] ++ (pkgs.callPackage ./normal.nix { }).bookmarks;
}
