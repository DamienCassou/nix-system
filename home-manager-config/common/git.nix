{
  config,
  pkgs,
  ...
}:
let
  emailAccount = config.accounts.email.accounts.perso;
  home = config.home.homeDirectory;
in
{
  home.packages = with pkgs; [
    gitAndTools.git-absorb
    gitAndTools.git-when-merged
    git-crypt
  ];

  programs.git = {
    enable = true;
    userEmail = emailAccount.address;
    userName = emailAccount.realName;
    package = pkgs.git.override {
      sendEmailSupport = true;
      withSsh = true;
      withLibsecret = !pkgs.stdenv.hostPlatform.isDarwin;
    };
    signing = {
      key = config.programs.gpg.settings.encrypt-to;
      signByDefault = true;
    };
    maintenance = {
      enable = true;
      # Large repositories that Git should cleanup regularly:
      repositories = [
        "${home}/.emacs.d"
        "${home}/personal/projects/nix/nixpkgs"
        "${home}/work/setup/monitor"
      ];
    };
    extraConfig = {
      absorb = {
        oneFixupPerCommit = true;
        forceAuthor = true;
      };
      core = {
        # Improves performance, see GIT-STATUS(1)
        untrackedCache = true;
        # Improves performance, see GIT-STATUS(1)
        fsmonitor = true;
      };
      github = {
        user = "DamienCassou";
      };
      gitlab = {
        user = "DamienCassou";
      };
      branch = {
        autosetuprebase = "always";
        sort = "-committerdate";
      };
      column = {
        ui = "auto";
      };
      diff = {
        algorithm = "histogram";
        colorMoved = "plain";
        mnemonicPrefix = true;
        renames = true;
      };
      log = {
        follow = true;
      };
      init = {
        defaultBranch = "main";
      };
      fetch = {
        prune = true;
        pruneTags = true;
        all = true;
      };
      help = {
        autocorrect = "prompt";
      };
      pull = {
        rebase = true;
      };
      push = {
        autoSetupRemote = true;
        followTags = true;
      };
      sendemail = {
        confirm = "auto";
      };
      tag = {
        sort = "version:refname";
      };
      "diff \"elisp\"" = {
        xfuncname = "^(\\(.*)$";
      };
      "diff \"orgmode\"" = {
        xfuncname = "^(\\*+.*)$";
      };
      "diff \"ecmascript\"" = {
        xfuncname = "^((.*function.*)|([ 	]+(static[ 	]+)?(async[ 	]+)?[[:alnum:]_]+\\(.*))$";
      };
      "diff \"ledger\"" = {
        xfuncname = "^[^ ].*$";
      };

      # Access github.com through SSH instead of HTTPS:
      "url \"git@github.com:\"" = {
        insteadOf = "https://github.com";
      };
    };
    attributes = [
      # My own xfuncname definitions:
      "*.el     diff=elisp"
      "*.org    diff=orgmode"
      "*.js     diff=ecmascript"
      "*.ledger diff=ledger"
      "*.hledger diff=ledger"
      # Built-in xfuncname definitions:
      "*.cs     diff=csharp"
    ];
    ignores = [
      # Info
      "*.info"
      "dir"
      # Emacs
      ".dir-locals.el"
      ".dir-locals-2.el"
      "*.elc"
      "*-autoloads.el"
      "flycheck_*.el"
      "*-pkg.el"
      "Eldev-local"
      ".project"
      "*~"
      ".conner"
      # JS
      ".tern-port"
      "node_modules"
      ".indium"
      # Syncthing
      ".stignore"
      # Nix
      "/shell.nix"
      # Direnv
      ".envrc"
      ".direnv/"
      # Syncthing
      ".stfolder"
    ];
  };
}
