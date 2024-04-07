{ ... }: {
  manual = {
    json.enable = true;
    html.enable = true;
    manpages.enable = true;
  };

  programs.man = {
    enable = true;
    generateCaches = true;
  };

  programs.info.enable = true;
}
