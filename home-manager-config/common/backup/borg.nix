{
  config,
  lib,
  pkgs,
  ...
}:

let
  borg-pass-command = "${pkgs.my-scripts}/bin/pass-show-password famille/lime2_borg";
  main-repository = "ssh://yrw00380@yrw00380.repo.borgbase.com/./repo";
in
{
  programs.borgmatic = {
    enable = true;
    backups = {
      main = {
        settings = {
          check_i_know_what_i_am_doing = true;
          checks = [
            {
              name = "repository";
              frequency = "2 weeks";
            }
            {
              name = "archives";
              frequency = "4 weeks";
            }
            {
              name = "data";
              frequency = "6 weeks";
            }
            {
              name = "extract";
              frequency = "6 weeks";
            }
          ];
          encryption_passcommand = borg-pass-command;
          exclude_from = [
            (pkgs.writeText "borg-exclude.txt" (pkgs.callPackage ./borg-excludes.nix { inherit config; }))
          ];
          keep_within = "2d";
          keep_hourly = 2;
          keep_daily = 7;
          keep_weekly = 4;
          keep_monthly = 6;
          keep_yearly = -1;
          one_file_system = true;
          repositories = [
            {
              path = main-repository;
              label = "borgbase";
            }
          ];
          source_directories = [ config.home.homeDirectory ];
          verbosity = 1;
        };
        location = {
          excludeHomeManagerSymlinks = true;
        };
      };
    };
  };

  services.borgmatic = {
    enable = true;
    frequency = "hourly";
  };

  home.sessionVariables = {
    BORG_PASSCOMMAND = borg-pass-command;
    BORG_REPO = main-repository;
  };

  launchd.agents.borgmatic.config.StartCalendarInterval = lib.mkForce [
    {
      Minute = 0;
      Hour = 8;
    }
    {
      Minute = 0;
      Hour = 12;
    }
    {
      Minute = 0;
      Hour = 16;
    }
    {
      Minute = 0;
      Hour = 20;
    }
  ];
}
