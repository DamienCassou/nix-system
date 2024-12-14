{ config, pkgs, ... }:

let
  aspel = pkgs.aspellWithDicts (
    dicts: with dicts; [
      en
      fr
    ]
  );
  iosevka-aile = pkgs.iosevka-bin.override { variant = "Aile"; };
  nixGLWrap = config.lib.nixGL.wrap;
in
{
  home.packages =
    [
      aspel
      iosevka-aile
    ]
    ++ (
      with pkgs;
      [
        (nixGLWrap calibre)
        (nixGLWrap element-desktop)
        (nixGLWrap ferdium) # for discord and mattermost
        (nixGLWrap parabolic) # download videos
        (nixGLWrap vlc)
        bc
        coreutils-full
        curl
        devenv
        diffutils
        direnv
        dmenu
        dot-language-server
        easytag
        eog
        evince
        ffmpeg-full # for ffplay, used by tmr-sound.el
        file
        findutils
        gawk
        gimp
        gnugrep
        gnumake
        gnused
        graphviz
        haskellPackages.hledger_1_40
        hunspellDicts.en_US-large
        hunspellDicts.fr-any
        hunspellDicts.fr-classique
        hunspellDicts.fr-moderne
        imagemagick
        inkscape
        ispell
        jq
        libreoffice
        lint-staged
        mpc_cli
        multimarkdown # to preview markdown files
        ncdu
        nitrokey-app2
        p7zip
        pandoc
        peek # for screencasts
        psmisc # for killall
        pwgen
        pynitrokey
        qpdf # to remove passwords from PDF
        rofi
        rofi-bluetooth
        rofi-pulse-select
        rsync
        shellcheck
        signal-desktop
        spice
        sqlite
        umlet
        unar # universal unpacker
        unzip
        usbutils
        wget
        wmname
        wofi
        xcape
        yaml-language-server
        yarn-bash-completion
        zbar # to scan QR codes for pass-otp
      ]
      ++ [
        # Unfree packages
        (nixGLWrap slack)
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
        noto-fonts-emoji # recommended by Emacs
        roboto-mono
        ubuntu_font_family
        xorg.fontmiscmisc
      ]
    );
}
