{ pkgs, ... }:

{
  stylix = {
    enable = true;
    image = ./wallpaper.jpg;
    imageScalingMode = "fill";
    base16Scheme = ./modus-operandi-theme.yaml;
    targets.emacs.enable = false;

    fonts = {
      serif = {
        package = pkgs.aporetic;
        name = "Aporetic Serif";
      };

      sansSerif = {
        package = pkgs.aporetic;
        name = "Aporetic Sans";
      };

      monospace = {
        package = pkgs.aporetic;
        name = "Aporetic Sans Mono";
      };
    };
  };
}
