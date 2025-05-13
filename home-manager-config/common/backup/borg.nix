{
  config,
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
        location = {
          sourceDirectories = [ config.home.homeDirectory ];
          repositories = [ main-repository ];
          excludeHomeManagerSymlinks = true;
          extraConfig = {
            one_file_system = true;
            exclude_from = [
              (pkgs.writeText "borg-exclude.txt" (pkgs.callPackage ./borg-excludes.nix { inherit config; }))
            ];
            check_i_know_what_i_am_doing = true;
            verbosity = 1;
          };
        };
        storage = {
          encryptionPasscommand = borg-pass-command;
        };
        retention = {
          keepWithin = "2d";
          keepHourly = 2;
          keepDaily = 7;
          keepWeekly = 4;
          keepMonthly = 6;
          keepYearly = -1;
        };
        consistency = {
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
}
