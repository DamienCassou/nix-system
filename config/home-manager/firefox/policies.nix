{ lib, ... }:
let
  settings = {
    "dom.security.https_only_mode" = true;
    "geo.enabled" = false; # disable localization
    "browser.newtabpage.enabled" = false;
    "browser.search.region" = "FR";
    "browser.startup.page" = 0;
    "browser.tabs.closeWindowWithLastTab" = false;
    "intl.accept_languages" = "en-us,fr,en";
  };

  convertSettingToPref = _: value: {
    Value = value;
    Status = "locked";
  };
in {
  policies = {
    DownloadDirectory = "\${home}/Downloads";
    DisplayBookmarksToolbar = "always";
    DisablePocket = true; # I don't use it
    EnableTrackingProtection = {
      "Value" = true;
      "Locked" = true; # don't let the user change that
      "Cryptomining" = true;
      # true sets time to UTC which is annoying when ordering delivery:
      "Fingerprinting" = false;
      "Exceptions" = [ ];
    };
    Handlers = {
      mimeTypes = { "application/pdf" = { action = "saveToDisk"; }; };
      schemes = {
        mailto = { handlers = [ { } ]; };
        slack = { };
      };
    };
    NetworkPrediction = false; # some more privacy
    NoDefaultBookmarks = true;
    OfferToSaveLogins = false;
    PasswordManagerEnabled = false;
    Permissions = {
      Camera = { };
      Microphone = { };
      Location = { };
      Notifications = { Block = [ "https://3.basecamp.com" ]; };
      Autoplay = { };
    };
    Preferences = lib.mapAttrs convertSettingToPref settings;
    RequestedLocales = [ "fr" "en-US" ];
    "3rdparty" = {
      Extensions = {
        "CookieAutoDelete@kennydo.com" = {
          "settings" = {
            "contextualIdentities" = {
              "name" = "contextualIdentities";
              "value" = true;
            };
          };
          "lists" = {
            "firefox-container-1" = [{
              "expression" = "*.basecamp.com";
              "listType" = "WHITE";
              "storeId" = "firefox-container-1";
              "cleanSiteData" = [ ];
              "cookieNames" = [ ];
              "id" = "ZhlmhpVRf";
            }];
          };
        };
      };
    };
  };
}
