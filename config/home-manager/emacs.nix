{ pkgs, ... }:

{
  nixpkgs.overlays = [ (import ../../emacs-overlay) ];

  programs.emacs = {
    enable = true;
    package = pkgs.emacs29-gtk3;
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
