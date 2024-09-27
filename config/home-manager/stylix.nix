{ pkgs, ... }@args:

{
  stylix = {
    enable = true;
    image = ./wallpaper.jpg;
    base16Scheme = ./modus-operandi-theme.yaml;
    targets.emacs.enable = false;

    fonts = {
      serif = {
        package = pkgs.gentium;
        name = "Gentium book plus";
      };

      sansSerif = {
        package = pkgs.gentium;
        name = "Gentium book plus";
      };

      monospace = {
        package = pkgs.jetbrains-mono;
        name = "JetBrains Mono Medium";
      };
    };
  };

  imports = [ ((import ../../stylix).homeManagerModules.stylix args) ];
}
