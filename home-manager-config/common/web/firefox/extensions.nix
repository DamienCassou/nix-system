{ pkgs, ... }:
{
  extensions.packages = with pkgs.firefox-addons; [
    auto-reject-cookies
    overview
    rsf-censorship-detector
    browserpass
    cookie-autodelete
    don-t-fuck-with-paste
    libredirect
    multi-account-containers
    ublock-origin
    wallabagger
  ];
}
