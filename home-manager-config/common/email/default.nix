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
          folderfilter = "lambda folder: folder in [ 'Sent', 'INBOX', 'Archive', 'Junk' ]";
        };
      };
    };

    accounts.booking = {
      primary = false;

      maildir.path = "Booking";
      address = "booking@lacantine-brest.net";
      realName = "Booking";

      userName = "booking@lacantine-brest.net";
      passwordCommand = "pass-show-password ssl0.ovh.net";

      folders.inbox = "Inbox";

      imap = {
        host = "ssl0.ovh.net";
        port = 993;
      };

      smtp = {
        host = "ssl0.ovh.net";
        port = 465;
      };

      signature = {
        showSignature = "append";
        text = ''
          Damien Cassou
          https://www.lacantine-brest.net/
        '';
      };

      msmtp.enable = true;
      notmuch.enable = true;

      offlineimap = {
        enable = true;

        extraConfig.remote = {
          folderfilter = "lambda folder: folder in [ 'INBOX.Sent', 'INBOX', 'INBOX.archives', 'INBOX.Spam' ]";
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

      # By default, emails with tags "spam" or "deleted" are invisible. I want all emails to be visible instead
      search.excludeTags = [ ];
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
