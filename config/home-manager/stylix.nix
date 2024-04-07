{ pkgs, ... }@args:

{
  stylix = {
    image = ./wallpaper.jpg;
    base16Scheme = ./modus-operandi-theme.yaml;
    targets.emacs.enable = false;

    fonts = {
      serif = {
        package = pkgs.iosevka-comfy.comfy-motion-duo;
        name = "Iosevka Comfy Motion Duo";
      };

      sansSerif = {
        package = pkgs.iosevka-comfy.comfy-wide-duo;
        name = "Iosevka Comfy Wide Duo";
      };

      monospace = {
        package = pkgs.iosevka-comfy.comfy-wide;
        name = "Iosevka Comfy Wide";
      };
    };
  };

  imports = [ ((import ../../stylix).homeManagerModules.stylix args) ];
}
