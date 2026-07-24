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
        verifyFingerprint = "06:B2:B0:6F:7B:35:20:85:59:8E:41:DC:E7:A4:F2:ED:F2:AF:7A:AB:0E:77:7D:5E:42:6D:F8:C2:05:73:ED:AC";
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
