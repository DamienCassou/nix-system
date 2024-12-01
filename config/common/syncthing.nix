{ lib, config, ... }:
let
  secretsPath = "${lib.elemAt config.nix.nixPath 0}/secrets/syncthing";
in
{
  services.syncthing = {
    enable = true;
    key = "${secretsPath}/key.pem";
    cert = "${secretsPath}/cert.pem";
    settings = {
      remoteIgnoredDevices = [
        {
          time = "2024-11-24T11:35:15.552Z";
          deviceID = "O4YPJCR-WCE7TDF-35BVVYH-V4DF4J5-7AH3VOD-XAHMVKR-LTCIA2Y-Y3EWBAD";
          name = "dany-desktop";
        }
        {
          time = "2024-11-24T11:35:15.552Z";
          deviceID = "MH4OL5B-TQFNW6O-GDHQCWO-XCPN5EU-7FHKT24-JIVB2NQ-FKPDROJ-XI6SEAO";
          name = "dany-laptop";
        }
      ];
      options = {
        # Whether the user has accepted to submit anonymous usage data:
        urAccepted = 3;
      };
      devices = {
        damien-laptop = {
          id = "ALY3FSC-DRDYHIE-KK7EIMM-4Z3ZAQ5-722OYQC-LAKHV2F-UWCMWX7-CQ7NNQX";
        };
        damien-phone = {
          id = "FKEGOYD-TVGWVEI-7C76YTJ-J5QKU5Z-GJ7SLUA-LRVCO7B-JQHJS6M-SWT3IAV";
        };
        jenny-laptop = {
          id = "2IW5WNQ-ZAXFF3Z-A6NRGJY-73PTLYK-OWF6AHV-OBAYWLT-LPP47MA-FYQ6DAR";
        };
        jenny-phone = {
          id = "OMTRTDA-6PW7LTK-LTLQK4E-UM4GCNW-JWHO3G6-5GZPAIX-JUW6UBO-4XH4IQ5";
        };
      };
      folders = {
        damien-laptop-notes = {
          id = "fwefy-w8ser";
          path = "~/personal/notes";
          devices = [
            "damien-laptop"
            "damien-phone"
          ];
        };
        damien-laptop-music = {
          id = "po7wp-7mahf";
          path = "~/Music";
          devices = [
            "damien-laptop"
            "jenny-laptop"
          ];
        };
        damien-laptop-password-store = {
          id = "ztfgz-hsa7j";
          path = "~/.password-store";
          devices = [
            "damien-laptop"
            "jenny-laptop"
          ];
        };
        damien-pixel7a-storage = {
          id = "jjzt2-exshh";
          path = "~/Documents/android/pixel7a/synced";
          devices = [
            "damien-laptop"
            "damien-phone"
          ];
        };
        famille-configuration = {
          id = "dt6n7-pzctx";
          path = "~/configuration/";
          devices = [
            "damien-laptop"
            "jenny-laptop"
          ];
        };
        famille-famille = {
          id = "awvrs-da24x";
          path = "~/famille";
          devices = [
            "damien-laptop"
            "jenny-laptop"
          ];
        };
        jenny-laptop-bureau = {
          id = "vpx44-y9zwk";
          path = "~/Bureau";
          devices = [
            "damien-laptop"
            "jenny-laptop"
          ];
        };
        liste-courses = {
          id = "h3l5h-usoqy";
          path = "~/liste-courses";
          devices = [
            "damien-laptop"
            "damien-phone"
            "jenny-phone"
          ];
        };
      };
    };
    extraOptions = [ ];
  };
}
