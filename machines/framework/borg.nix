{
  config,
  lib,
  pkgs,
  ...
}:

let
  main-repository = "ssh://ujhegv10@ujhegv10.repo.borgbase.com/./repo";
  borg-pass-command = "${pkgs.pass-show-password}/bin/pass-show-password.sh Jenny/borgbase-home-jenny";
in
{
  programs.borgmatic = {
    enable = true;
    backups = {
      main = {
        location = {
          sourceDirectories = [ config.home.homeDirectory ];
          repositories = [ main-repository ];
          extraConfig = {
            one_file_system = true;
            exclude_from = [ ./borg-excludes.txt ];
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

  systemd.user.services.borgmatic = {
    # Overwrite ExecStart to avoid systemd-inhibit:
    Service.ExecStart = lib.mkForce ''
      ${config.programs.borgmatic.package}/bin/borgmatic \
           --stats \
           --verbosity -1 \
           --list \
           --syslog-verbosity 1
    '';

    Unit.OnFailure = "status_email_user@%n.service";
  };

  home.sessionVariables = {
    BORG_PASSCOMMAND = borg-pass-command;
    BORG_REPO = main-repository;
  };
}
