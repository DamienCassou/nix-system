_: {
  # Reference links:
  # - https://restoreprivacy.com/firefox-privacy/
  # - https://arkenfox.github.io/gui/
  settings = {
    accessibility.typeaheadfind.enablesound = false;
    # By default firefox blocks 5060 which we need for ReportApi
    # (https://superuser.com/questions/188006/how-to-fix-err-unsafe-port-error-on-chrome-when-browsing-to-unsafe-ports)
    "network.security.ports.banned.override" = "1-65535";
    # Privacy
    "privacy.firstparty.isolate" = true;
    # Misc
    "services.sync.engine.passwords" = false;
    "services.sync.username" = "damien@cassou.me";
  };
}
