{
  lib,
  config,
  pkgs,
  ...
}:
{
  home.shell.enableBashIntegration = true;

  programs = {

    bash = {
      historyControl = [ "erasedups" ];
      historyFile = "${config.xdg.dataHome}/bash/history";
      enable = true;
      shellAliases = {
        "borgcheck" = "borgmatic --verbosity 2 check --repair --progress  --force --only";
        "docker-cleanup" = "docker system prune --volumes";
        "hm" = "home-manager --flake $NIX_PATH";
        "youtube-dl-album" =
          "${lib.getExe pkgs.yt-dlp} --extract-audio --audio-format mp3 --audio-quality 0 --yes-playlist";
      };
      initExtra = ''
        function vterm_printf(){
            if [ -n "$TMUX" ] \
                && { [ "''${TERM%%-*}" = "tmux" ] \
                    || [ "''${TERM%%-*}" = "screen" ]; }; then
                # Tell tmux to pass the escape sequences through
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
    };

    readline = {
      enable = true;
      variables = {
        bell-style = "none";
      };
    };

    powerline-go = {
      enable = false;
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
      settings = {
        hostname-only-if-ssh = true;
        numeric-exit-codes = true;
        cwd-max-depth = 7;
      };
    };

    starship = {
      enable = true;
      settings = {
        add_newline = true;
        command_timeout = 1000;
        status = {
          disabled = false;
        };
        directory = {
          truncation_length = 7;
          truncate_to_repo = false;
        };
        git_commit = {
          disabled = true;
        };
        git_status = {
          disabled = true;
        };
      };
    };
  };
}
