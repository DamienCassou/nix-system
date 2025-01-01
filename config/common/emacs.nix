{ lib, pkgs, ... }:

let
  copilot-node-server = pkgs.copilot-node-server.overrideAttrs (old: rec {
    version = "1.27.0";
    src = pkgs.fetchFromGitHub {
      owner = "jfcherng";
      repo = "copilot-node-server";
      rev = version;
      hash = "sha256-Ds2agoO7LBXI2M1dwvifQyYJ3F9fm9eV2Kmm7WITgyo=";
    };
  });
in
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

  programs.emacs.extraConfig = ''
    (setq magit-perl-executable "${lib.getExe pkgs.perl}")
    (setq copilot-install-dir "${copilot-node-server}")
  '';

  home.packages = with pkgs; [
    emacs-all-the-icons-fonts
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
