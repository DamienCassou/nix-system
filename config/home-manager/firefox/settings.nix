{ ... }: {
  # Reference links:
  # - https://restoreprivacy.com/firefox-privacy/
  # - https://arkenfox.github.io/gui/
  settings = {
    # Privacy
    "dom.security.https_only_mode" = true;
    "geo.enabled" = false; # disable localization
    "privacy.firstparty.isolate" = true;
    # Misc
    "services.sync.engine.passwords" = false;
    "services.sync.username" = "damien@cassou.me";
  };
}
