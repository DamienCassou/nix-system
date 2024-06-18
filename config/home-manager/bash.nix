{
  lib,
  config,
  pkgs,
  ...
}:
{
  programs = {

    bash = {
      historyControl = [ "erasedups" ];
      historyFile = "${config.xdg.dataHome}/bash/history";
      enable = true;
      shellAliases = {
        "borgcheck" = "borgmatic --verbosity 2 check --repair --progress  --force --only";
        "dnf-list" = "dnf repoquery --list";
        "dnf-provides" = "dnf repoquery --cacheonly --file";
        "hm" = "home-manager";
        "nixpkgs-bump" = "nix-shell maintainers/scripts/update.nix --argstr package";
        "youtube-dl-album" = "${lib.getExe pkgs.yt-dlp} --extract-audio --audio-format mp3 --audio-quality 0 --yes-playlist";
      };
      initExtra = ''
        function vterm_printf(){
            if [ -n "$TMUX" ]; then
                # Tell tmux to pass the escape sequences through
                # (Source: http://permalink.gmane.org/gmane.comp.terminal-emulators.tmux.user/1324)
                printf "\ePtmux;\e\e]%s\007\e\\" "$1"
            elif [ "''${TERM%%-*}" = "screen" ]; then
                # GNU screen (screen, screen-256color, screen-256color-bce)
                printf "\eP\e]%s\007\e\\" "$1"
            else
                printf "\e]%s\e\\" "$1"
            fi
        }

        vterm_prompt_end(){
            vterm_printf "51;A$(whoami)@$(hostname):$(pwd)"
        }

        # Show the executing command in the terminal's title
        # https://stackoverflow.com/questions/5076127/bash-update-terminal-title-by-running-a-second-command
        trap 'echo -ne "\033]2;$(history 1 | ${pkgs.gnused}/bin/sed "s/^[ ]*[0-9]*[ ]*//g")\007"' DEBUG
      '';
      profileExtra = ''
        # Deactivate the audible bell in X
        xset -b
      '';
    };

    readline = {
      enable = true;
      variables = {
        bell-style = "none";
      };
    };

    powerline-go = {
      enable = true;
      extraUpdatePS1 = ''
        # Let vterm detect the end of the prompt:
        PS1=$PS1'\[$(vterm_prompt_end)\]'
      '';
      newline = true;
      modules = [
        "venv"
        "dotenv"
        "nix-shell"
        "host"
        "ssh"
        "cwd"
        "jobs"
        "exit"
        "termtitle"
      ];
      pathAliases = {
        "\\~/Documents/projects/ftgp/monitor/monitor/Monitor.Web.Ui/Client" = "monitor-client";
        "\\~/Documents/projects/ftgp/monitor" = "monitor";
        "\\~/Documents/projects" = "prj";
      };
      settings = {
        hostname-only-if-ssh = true;
        numeric-exit-codes = true;
        cwd-max-depth = 7;
      };
    };
  };

}
