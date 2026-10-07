{ pkgs, ... }: {
  home.extraOutputsToInstall = [ "doc" ];

  manual = {
    json.enable = true;
    html.enable = true;
    manpages.enable = true;
  };

  programs.man = {
    enable = true;
    generateCaches = !pkgs.stdenv.hostPlatform.isDarwin;
  };

  programs.info.enable = true;
}
