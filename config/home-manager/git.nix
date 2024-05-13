{ config, pkgs, ... }:
let
  emailAccount = config.accounts.email.accounts.perso;
in
{
  programs.git = {
    enable = true;
    userEmail = emailAccount.address;
    userName = emailAccount.realName;
    package = pkgs.gitAndTools.gitFull;
    signing = {
      key = config.programs.gpg.settings.encrypt-to;
      signByDefault = true;
    };
    extraConfig = {
      github = {
        user = "DamienCassou";
      };
      gitlab = {
        user = "DamienCassou";
      };
      branch = {
        autosetuprebase = "always";
      };
      log = {
        follow = true;
      };
      init = {
        defaultBranch = "main";
      };
      fetch = {
        prune = true;
      };
      pull = {
        rebase = true;
      };
      sendemail = {
        confirm = "auto";
      };
      maintenance = {
        # Large repositories that Git should cleanup regularly:
        repo = [
          "/home/cassou/Documents/projects/nix-system/nixpkgs"
          "/home/cassou/.emacs.d"
          "/home/cassou/Documents/projects/ftgp/finsit/monitor"
        ];
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
    ];
  };
}
