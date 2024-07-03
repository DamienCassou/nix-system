{ pkgs, ... }:

{
  nixpkgs.overlays = [ (import ../../emacs-overlay) ];

  programs.emacs = {
    enable = true;
    package = pkgs.emacs-unstable.overrideAttrs (old: {
      patches = old.patches ++ [ ./patches/0001-Fix-treesit-range-rule-for-jsdoc.patch ];
    });
    extraPackages =
      epkgs: with epkgs; [
        all-the-icons
        closql # for forge
        compat
        eglot
        epkg
        epkg-marginalia
        jinx
        org
        pdf-tools
        pkgs.notmuch.emacs
        queue
        request
        treesit-grammars.with-all-grammars
        transient
        vterm
      ];
  };

  home.packages = with pkgs; [
    emacs-all-the-icons-fonts
    # For emacs-everywhere:
    xclip
    xdotool
    xorg.xprop
    xorg.xwininfo
  ];

  services.emacs = {
    enable = true;
    defaultEditor = true;
    socketActivation.enable = true;
    startWithUserSession = "graphical";
  };

  xresources = {
    properties = {
      "emacs*menuBar" = false;
      "emacs*toolBar" = false;
      "emacs*verticalScrollBars" = false;
    };
  };
}
