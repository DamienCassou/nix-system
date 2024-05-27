{ pkgs, ... }:
{
  extensions = with pkgs.nur.repos.rycee.firefox-addons; [
    overview
    rsf-censorship-detector
    browserpass
    cookie-autodelete
    don-t-fuck-with-paste
    i-dont-care-about-cookies
    libredirect
    multi-account-containers
    react-devtools
    refined-github
    ublock-origin
    wallabagger
  ];
}
