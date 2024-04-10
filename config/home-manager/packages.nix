{ pkgs, ... }:

let
  ledger-autosync =
    (pkgs.ledger-autosync.override {
      useLedger = false;
      useHledger = true;
    }).overrideAttrs
      (old: {
        patches = [ ./patches/ledger-autosync-use-expense-account.patch ];
      });
  iosevka-aile = pkgs.iosevka-bin.override { variant = "Aile"; };
  nixGLIntel = (pkgs.callPackage ../../nixGL { }).nixGLIntel;
in
{
  nixpkgs.overlays = [ (self: super: { inherit nixGLIntel; }) ];

  home.packages =
    [
      ledger-autosync
      iosevka-aile
    ]
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
        bash
        bc
        blobfuse
        blueman
        brightnessctl
        cachix
        calibre
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
        eslint_d
        evince
        feh
        ferdium
        ffmpeg-full # for ffplay, used by tmr-sound.el
        file
        findutils
        gawk
        gimp
        gitAndTools.git-absorb
        gitAndTools.git-when-merged
        gnome3.eog
        gnugrep
        gnumake
        gnused
        graphviz
        haskellPackages.hledger
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
        mpc_cli
        msmtp
        multimarkdown # to preview markdown files
        ncdu
        networkmanager # for nmcli
        nil # LSP server for Nix
        niv
        nixGLIntel
        nixVersions.stable
        nixfmt-rfc-style
        nixpkgs-fmt # nix formatter for nixpkgs code base
        nodePackages.bash-language-server
        nodePackages.node2nix
        nodePackages.typescript
        nodePackages.typescript-language-server
        nodePackages.dockerfile-language-server-nodejs
        nodePackages.vscode-json-languageserver
        nodejs_20
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
        transmission-gtk
        umlet
        unar # universal unpacker
        unison
        unzip
        usbutils
        vlc
        vscode-langservers-extracted
        wget
        wmname
        xcape
        xdg-utils
        xorg.xmodmap
        xorg.xrdb
        xorg.xset
        yaml-language-server
        yarn
        yarn-bash-completion
        wofi
        zbar # to scan QR codes for pass-otp
      ]
      ++ [
        # Unfree packages
        slack
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
