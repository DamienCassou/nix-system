{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.emacs = {
    enable = true;
    extraPackages = epkgs: [
      epkgs.ace-window
      epkgs.aggressive-indent
      epkgs.alert
      epkgs.all-the-icons-dired
      epkgs.auto-compile
      epkgs.avy
      epkgs.beginend
      epkgs.buttercup
      epkgs.cape
      epkgs.casual
      epkgs.compat
      epkgs.conner
      epkgs.consult
      epkgs.copilot-chat
      epkgs.dape
      epkgs.denote
      epkgs.diff-hl
      epkgs.dired-imenu
      epkgs.dired-rsync
      epkgs.docker
      epkgs.dotenv-mode
      epkgs.drag-stuff
      epkgs.dumb-jump
      epkgs.dwim-shell-command
      epkgs.edit-indirect
      epkgs.editorconfig
      epkgs.eglot
      epkgs.elcouch
      epkgs.embark
      epkgs.embark-consult
      epkgs.embrace
      epkgs.epkg
      epkgs.epkg-marginalia
      epkgs.eslint-disable-rule
      epkgs.expand-region
      epkgs.flymake
      epkgs.flymake-eslint
      epkgs.flymake-hledger
      epkgs.fontaine
      epkgs.forge
      epkgs.git-timemachine
      epkgs.graphviz-dot-mode
      epkgs.htmlize
      epkgs.imenu-list
      epkgs.jinx
      epkgs.js2-mode
      epkgs.js2-refactor
      epkgs.khardel
      epkgs.know-your-http-well
      epkgs.launchctl
      epkgs.ledger-mode
      epkgs.libbcel
      epkgs.ligature
      epkgs.lin
      epkgs.macrostep
      epkgs.magit
      epkgs.magit-tbdiff
      epkgs.marginalia
      epkgs.markdown-mode
      epkgs.minions
      epkgs.mpdel
      epkgs.mpdel-embark
      epkgs.multiple-cursors
      epkgs.nameless
      epkgs.nginx-mode
      epkgs.nix-mode
      epkgs.nix-ts-mode
      epkgs.no-littering
      epkgs.nov
      epkgs.olivetti
      epkgs.orderless
      epkgs.org
      epkgs.org-caldav
      epkgs.ox-linuxmag-fr
      epkgs.package-lint
      epkgs.package-lint-flymake
      epkgs.paredit
      epkgs.paren-face
      epkgs.pass
      epkgs.password-store
      epkgs.pdf-tools
      epkgs.prodigy
      epkgs.project
      epkgs.reformatter
      epkgs.related-files
      epkgs.rjsx-mode
      epkgs.runner
      epkgs.spacious-padding
      epkgs.tmr
      epkgs.treesit-grammars.with-all-grammars
      epkgs.typescript-mode
      epkgs.unify-opening
      epkgs.verb
      epkgs.vertico
      epkgs.vterm
      epkgs.vundo
      epkgs.webpaste
      epkgs.wgrep
      epkgs.melpaPackages.ws-butler
      epkgs.xref
      epkgs.xref-js2
      epkgs.yasnippet
      epkgs.ytdl
      pkgs.notmuch.emacs
    ];
  };

  programs.emacs.extraConfig = ''
    (setq magit-perl-executable "${lib.getExe pkgs.perl}")
    (setq libmpdel-music-directory "${config.services.mpd.musicDirectory}")
  '';

  home.packages = with pkgs; [
    emacs-all-the-icons-fonts
  ];

  xresources = {
    properties = {
      "emacs*menuBar" = false;
      "emacs*toolBar" = false;
      "emacs*verticalScrollBars" = false;
    };
  };
}
