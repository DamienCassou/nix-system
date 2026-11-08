{ ... }:
{
  home.file = {
    ".unison/default.prf".text = ''
      ignore = Name .DS_Store
      ignore = Name fsmonitor--daemon.ipc
      ignore = Name node_modules
      ignore = Name .~lock*

      servercmd = /home/cassou/.nix-profile/bin/unison
    '';
    ".unison/famille.prf".text = ''
      include default

      root = /Users/cassou/personal/famille
      root = ssh://framework//home/cassou/famille
    '';
    ".unison/jenny-bureau.prf".text = ''
      include default

      root = /Users/cassou/personal/jenny/Bureau
      root = ssh://framework//home/cassou/Bureau

      ignore = Path jenny/Mes_creations/roman/ombeline/ombeline_tome_1/conversion/scripts/node_modules
    '';
    ".unison/music.prf".text = ''
      include default

      root = /Users/cassou/personal/music
      root = ssh://framework//home/cassou/Music
    '';
    ".unison/password-store.prf".text = ''
      include default

      root = /Users/cassou/.password-store
      root = ssh://framework//home/cassou/.password-store

      ignore = Path .git
    '';
  };
}
