{ pkgs, ... }:
{
  extensions.packages = with pkgs.firefox-addons; [
    overview
    rsf-censorship-detector
    browserpass
    cookie-autodelete
    don-t-fuck-with-paste
    i-dont-care-about-cookies
    libredirect
    multi-account-containers
    react-devtools
    ublock-origin
    wallabagger
  ];
}
