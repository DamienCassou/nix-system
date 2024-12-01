{ pkgs, ... }:

{
  stylix = {
    enable = true;
    image = ./wallpaper.jpg;
    base16Scheme = ./modus-operandi-theme.yaml;
    targets.emacs.enable = false;

    fonts = {
      serif = {
        package = pkgs.atkinson-hyperlegible;
        name = "Atkinson Hyperlegible";
      };

      sansSerif = {
        package = pkgs.atkinson-hyperlegible;
        name = "Atkinson Hyperlegible";
      };

      monospace = {
        package = pkgs.jetbrains-mono;
        name = "JetBrains Mono Medium";
      };
    };
  };
}
