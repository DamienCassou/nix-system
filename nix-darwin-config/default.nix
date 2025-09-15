{
  lib,
  pkgs,
  ...
}:
{
  imports = [ ./homebrew.nix ];

  environment = {
    extraOutputsToInstall = [
      "devdoc"
      "doc"
      "info"
    ];

    shells = [ pkgs.bashInteractive ];
  };

  launchd.user = {
    agents.setenv.serviceConfig =
      let
        vars = {
          HOMEBREW_PREFIX = "/opt/homebrew";
          HOMEBREW_CELLAR = "/opt/homebrew/Cellar";
          HOMEBREW_REPOSITORY = "/opt/homebrew";
        };
      in
      {
        ProgramArguments = [
          "launchctl"
          "setenv"
        ]
        ++ (lib.flatten (
          lib.mapAttrsToList (varName: varValue: [
            varName
            varValue
          ]) vars
        ));
        RunAtLoad = true;
      };
  };

  nix.settings = {
    experimental-features = "nix-command flakes";
    trusted-users = [ "cassou" ];
  };

  nixpkgs.hostPlatform = "aarch64-darwin";

  programs = {
    bash = {
      enable = true;
      completion.enable = true;
    };
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    info.enable = true;
    man.enable = true;
  };

  system = {
    defaults = {
      ActivityMonitor = {
        ShowCategory = 100; # show All Processes
        SortColumn = "CPUUsage";
        SortDirection = 0; # Descending
      };

      CustomUserPreferences = { };

      CustomSystemPreferences = { };

      controlcenter = {
        AirDrop = false;
        BatteryShowPercentage = true;
        NowPlaying = false;
      };

      dock = {
        autohide = true;
        show-recents = false;
      };

      finder = {
        AppleShowAllExtensions = true;
        AppleShowAllFiles = true;
        NewWindowTarget = "Home";
        ShowPathbar = true;
      };

      iCal = {
        CalendarSidebarShown = true;
        "first day of week" = "Monday";
      };

      LaunchServices = {
        LSQuarantine = false;
      };

      loginwindow = {
        LoginwindowText = "valeur de nix-system";
        SHOWFULLNAME = false;
      };

      menuExtraClock = {
        ShowDate = 1;
        ShowSeconds = false;
      };

      NSGlobalDomain = {
        AppleScrollerPagingBehavior = true; # Jump to the spot that’s clicked on the scroll bar
        AppleShowAllExtensions = true;
        AppleShowAllFiles = true;
        NSAutomaticCapitalizationEnabled = false;
        NSAutomaticDashSubstitutionEnabled = false;
        NSAutomaticInlinePredictionEnabled = false;
        NSAutomaticPeriodSubstitutionEnabled = false;
        NSAutomaticQuoteSubstitutionEnabled = false;
        NSAutomaticSpellingCorrectionEnabled = false;
        NSDocumentSaveNewDocumentsToCloud = false;
        PMPrintingExpandedStateForPrint = true;
        PMPrintingExpandedStateForPrint2 = true;
      };

      SoftwareUpdate.AutomaticallyInstallMacOSUpdates = false;
    };

    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToControl = true;
    };

    primaryUser = "cassou";
    stateVersion = 6;
  };

  time = {
    timeZone = "Europe/Paris";
  };

  users.users.cassou = {
    description = "Damien Cassou";
    home = "/Users/cassou";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPNt/RcAiO+zgCvPUBXGHwPRr1qpufb/+tZlSab5D0cM cardno:000F_F29888AB"
    ];
    shell = pkgs.bashInteractive;
  };
}
