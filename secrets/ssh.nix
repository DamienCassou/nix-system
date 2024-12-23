{ pkgs, ... }:
{

  # Places where the key is being used:
  # - github
  # - gitlab
  # - gitlab.freedesktop.org
  # - librem14
  # - savannah.gnu.org
  # - borgbase

  home.packages = with pkgs; [
    openssh
  ];

  programs.ssh = {
    enable = true;
    matchBlocks = {
      librem14 = {
        hostname = "192.168.1.20";
      };
      "*.repo.borgbase.com" = {
        # For borg (the same has to be done on the server):
        # https://borgbackup.readthedocs.io/en/stable/usage/serve.html#ssh-configuration
        serverAliveInterval = 10;
        serverAliveCountMax = 30;
      };
      bastion-rsf = {
        hostname = "34.241.0.40";
        user = "admin";
        port = 11984;
      };
      "cantine" = {
        hostname = "51.91.142.70";
        user = "ubuntu";
      };
      "finsit-period-report-extraction-script" = {
        # need the finsit test VPN
        hostname = "10.20.20.5";
        user = "ftgp";
      };
    };
  };
}
