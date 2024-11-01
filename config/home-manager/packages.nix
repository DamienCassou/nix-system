{ config, pkgs, ... }:

let
  iosevka-aile = pkgs.iosevka-bin.override { variant = "Aile"; };
  nixGLWrap = config.lib.nixGL.wrap;
in
{
  home.packages =
    [ iosevka-aile ]
    ++ (
      with pkgs;
      [
        (aspellWithDicts (
          dicts: with dicts; [
            en
            fr
          ]
        ))
        arandr
        bash-language-server
        bc
        blobfuse
        blueman
        brightnessctl
        cachix
        (nixGLWrap calibre)
        copilot-node-server
        coreutils-full
        curl
        devenv
        diffutils
        direnv
        dmenu
        dmidecode
        discord
        dot-language-server
        easytag
        element-desktop
        eog
        evince
        (nixGLWrap ferdium) # for discord and mattermost
        ffmpeg-full # for ffplay, used by tmr-sound.el
        file
        findutils
        gawk
        gimp
        gitAndTools.git-absorb
        gitAndTools.git-when-merged
        gnugrep
        gnumake
        gnused
        graphviz
        haskellPackages.hledger_1_40
        hunspellDicts.en_US-large
        hunspellDicts.fr-any
        hunspellDicts.fr-moderne
        hunspellDicts.fr-classique
        imagemagick
        inkscape
        ispell
        jq
        khard
        libreoffice
        lint-staged
        (nixGLWrap mattermost-desktop)
        mpc_cli
        msmtp
        multimarkdown # to preview markdown files
        ncdu
        networkmanager # for nmcli
        nil # LSP server for Nix
        nitrokey-app2
        niv
        nixVersions.stable
        nixfmt-rfc-style
        nixpkgs-fmt # nix formatter for nixpkgs code base
        nodePackages.node2nix
        nodePackages.typescript
        nodePackages.dockerfile-language-server-nodejs
        nodePackages.vscode-json-languageserver
        notmuch
        omnisharp-roslyn # for C# development in Monitor
        openssh
        p7zip
        pandoc
        parabolic # download videos
        patch
        patchutils
        pavucontrol
        pciutils
        peek # for screencasts
        perl # for magit (magit-perl-executable)
        process-compose
        psmisc # for killall
        pulseaudio
        python3Packages.woob
        pynitrokey
        pwgen
        qpdf # to remove passwords from PDF
        racket # for SICP scheme implementation
        remmina
        rofi
        rofi-bluetooth
        rofi-pulse-select
        rsync
        shellcheck
        signal-desktop
        spice
        sqlite
        tor-browser
        transmission_4-gtk
        typescript-language-server
        umlet
        unar # universal unpacker
        unzip
        usbutils
        vlc
        vscode-js-debug
        vscode-langservers-extracted
        wget
        wmname
        xcape
        xdg-utils
        xorg.xmodmap
        xorg.xrdb
        xorg.xset
        yaml-language-server
        yarn-bash-completion
        wofi
        zbar # to scan QR codes for pass-otp
      ]
      ++ [
        # Unfree packages
        (nixGLWrap slack)
        teams-for-linux
        unrar
        zip
      ]
      ++ [
        # Fonts
        cantarell-fonts
        dejavu_fonts
        fira
        fira-code
        fira-mono
        font-awesome
        gentium
        gentium-book-basic
        inconsolata
        iosevka-bin
        iosevka-comfy.comfy
        iosevka-comfy.comfy-duo
        iosevka-comfy.comfy-motion
        iosevka-comfy.comfy-motion-duo
        jetbrains-mono
        liberation_ttf
        nerdfonts # for nano-modeline
        noto-fonts-emoji # recommended by Emacs
        roboto-mono
        ubuntu_font_family
        xorg.fontmiscmisc
      ]
    );
}
