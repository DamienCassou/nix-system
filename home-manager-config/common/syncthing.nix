{ ... }:
{
  services.syncthing = {
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
        damien-macbook = {
          id = "ALY3FSC-DRDYHIE-KK7EIMM-4Z3ZAQ5-722OYQC-LAKHV2F-UWCMWX7-CQ7NNQX";
        };
        damien-luz5 = {
          id = "HZQCAZ3-UDIZWNV-3MQ4LUD-ADC5ZY6-JD237ON-6XA3HQL-XT27X6Y-54D7DA3";
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
        raspberrypi = {
          id = "5DN4N3V-76PNQHO-MPVKVIR-7PEDJWW-FGG6RZD-3R633U2-BW3MVJ4-IOH4QAT";
        };
      };
    };
    extraOptions = [ ];
  };
}
