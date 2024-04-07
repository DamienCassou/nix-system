{ pkgs, ... }: {
  bookmarks = [
    {
      name = "Startup Bookmarks";
      bookmarks = (pkgs.callPackage ./startup.nix { }).bookmarks;
    }
    {
      name = "Bookmarks Toolbar";
      toolbar = true;
      bookmarks = (pkgs.callPackage ./toolbar.nix { }).bookmarks;
    }
  ] ++ (pkgs.callPackage ./normal.nix { }).bookmarks;
}
