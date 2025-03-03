{
  lib,
  config,
  pkgs,
  ...
}:
{
  accounts.email = {
    maildirBasePath = "personal/emails";

    accounts.perso = {
      primary = true;

      maildir.path = "Perso";
      address = "damien@cassou.me";
      realName = "Damien Cassou";

      userName = "damien@cassou.me";
      passwordCommand = "pass-show-password mail.reprendre.net/damien";

      folders.inbox = "INBOX";

      imap = {
        host = "mail.reprendre.net";
        port = 993;
      };

      smtp = {
        host = "mail.reprendre.net";
        port = 465;
      };

      signature = {
        showSignature = "append";
        text = ''
          Damien Cassou

          "Success is the ability to go from one failure to another without
          losing enthusiasm." --Winston Churchill
        '';
      };

      msmtp.enable = true;
      notmuch.enable = true;

      offlineimap = {
        enable = true;

        extraConfig.remote = {
          folderfilter = "lambda folder: folder in [ 'Sent', 'INBOX', 'Archive' ]";
        };
      };
    };
  };

  programs = {
    offlineimap.enable = true;
    msmtp.enable = true;

    notmuch = {
      enable = true;
      new.tags = [
        "unread"
        "inbox"
      ];
      hooks.preNew = ''
        ${./archive-emails.sh}
        ${lib.getExe pkgs.offlineimap}
      '';
    };
  };

  home = {
    file.".signature".text = config.accounts.email.accounts.perso.signature.text;

    packages = with pkgs; [
      msmtp
    ];

    sessionVariables.MAILDIR = "${config.accounts.email.maildirBasePath}";
  };
}
