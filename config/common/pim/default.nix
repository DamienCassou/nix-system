{ config, ... }:

{
  programs.vdirsyncer = {
    enable = true;
  };

  programs.khard = {
    enable = true;
    settings = {
      general = {
        editor = [ "emacsclient" ];
        merge_editor = [ "emacsclient" ];
        default_action = "list";
        show_nicknames = false;
      };
    };
  };

  services.vdirsyncer = {
    enable = true;
    frequency = "daily";
    verbosity = "INFO";
  };

  accounts.contact.accounts = {
    ninja = {
      vdirsyncer = {
        enable = true;
        conflictResolution = [ "${./merge-vdirsyncer-conflicts.sh}" ];
        collections = null;
        postHook = "git -C ${config.accounts.contact.accounts.ninja.local.path} commit --all --message='Update'";
      };
      khard = {
        enable = true;
      };
      local = {
        path = "${config.home.homeDirectory}/personal/contacts";
        type = "filesystem";
        fileExt = ".vcf";
      };
      remote = {
        passwordCommand = [
          "pass-show-password"
          "licorne.ninja"
        ];
        type = "carddav";
        url = "https://licorne.ninja/remote.php/dav/addressbooks/users/DamienCassou/contacts/";
        userName = "DamienCassou";
      };
    };
  };
}
