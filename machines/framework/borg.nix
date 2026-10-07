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
        settings = {
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
          exclude_from = [ ./borg-excludes.txt ];
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
