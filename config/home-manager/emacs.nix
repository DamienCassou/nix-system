{ pkgs, ... }:

{
  nixpkgs.overlays = [ (import ../../emacs-overlay) ];

  programs.emacs = {
    enable = true;
    package = pkgs.emacs-unstable.overrideAttrs (old: {
      patches = old.patches ++ [
        ./patches/emacs-0001-Handle-an-edge-case-in-c-ts-mode-filling-bug-72116.patch
      ];
    });
    extraPackages =
      epkgs: with epkgs; [
        all-the-icons
        closql # for forge
        compat
        editorconfig # because of bug#72790
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
