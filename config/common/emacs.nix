{ pkgs, ... }:

{
  programs.emacs = {
    enable = true;
    package = pkgs.emacs-unstable.overrideAttrs (old: {
      patches = old.patches ++ [ ];
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
        helm
        jinx
        org
        pdf-tools
        (pkgs.notmuch.overrideAttrs (old: {
          patches = (old.patches or [ ]) ++ [ ./patches/0001-emacs-show-Only-recenter-interactively.patch ];
        })).emacs
        queue
        request
        treesit-grammars.with-all-grammars
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
