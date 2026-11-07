{ config, pkgs-unstable, ... }:

{
  programs.vdirsyncer = {
    enable = true;
  };

  programs.pimsync = {
    enable = true;
    package = pkgs-unstable.pimsync;
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

  accounts.contact.accounts = {
    ninja = {
      pimsync = {
        enable = true;
        extraPairDirectives = [
          {
            name = "collection";
            params = [ "contacts" ];
          }
          {
            name = "conflict_resolution";
            params = [
              "cmd"
              "${./merge-vdirsyncer-conflicts.sh}"
            ];
          }
        ];
      };
      khard = {
        enable = true;
        addressbooks = [ "contacts" ];
      };
      local = {
        path = "${config.home.homeDirectory}/personal";
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
