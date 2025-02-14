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
        (nixGLWrap element-desktop)
        bc # calculator
        coreutils-full
        curl
        diffutils
        direnv
        dmenu
        dot-language-server
        easytag
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
        stable.haskellPackages.hledger_1_40
        hunspellDicts.en_US-large
        hunspellDicts.fr-any
        hunspellDicts.fr-classique
        hunspellDicts.fr-moderne
        imagemagick
        inkscape
        ispell
        jq
        multimarkdown # to preview markdown files
        ncdu
        p7zip
        pandoc
        pwgen
        qpdf # to remove passwords from PDF
        rsync
        signal-desktop
        spice
        sqlite
        umlet
        unar # universal unpacker
        unzip
        wget
        wmname
        yaml-language-server
        yarn-bash-completion
        zbar # to scan QR codes for pass-otp
      ]
      ++ [
        # Unfree packages
        (nixGLWrap teams-for-linux)
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
