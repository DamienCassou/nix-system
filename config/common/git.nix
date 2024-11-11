{
  config,
  pkgs,
  lib,
  ...
}:
let
  emailAccount = config.accounts.email.accounts.perso;
  home = config.home.homeDirectory;
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
    includes = [
      {
        condition = "hasconfig:remote.*.url:git@github.com:foretagsplatsen/**";
        path = pkgs.writeText "finsitGitConfig" (
          lib.generators.toGitINI {
            user.email = "damien.cassou@wolterskluwer.com";
          }
        );
      }
    ];
    maintenance = {
      enable = true;
      # Large repositories that Git should cleanup regularly:
      repositories = [
        "${home}/Documents/projects/nix-system/nixpkgs"
        "${home}/.emacs.d"
        "${home}/Documents/projects/ftgp/finsit/monitor"
      ];
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
