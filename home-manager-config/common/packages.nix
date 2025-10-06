{ pkgs, ... }:

let
  aspel = pkgs.aspellWithDicts (
    dicts: with dicts; [
      en
      fr
    ]
  );
  iosevka-aile = pkgs.iosevka-bin.override { variant = "Aile"; };
in
{
  home.packages = [
    aspel
    iosevka-aile
  ]
  ++ (
    with pkgs;
    [
      bc # calculator
      coreutils-full
      curl
      diffutils
      direnv
      dmenu
      dot-language-server
      easytag
      ffmpeg-full # for ffplay, used by tmr-sound.el
      file
      findutils
      gawk
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
      ispell
      jq
      multimarkdown # to preview markdown files
      ncdu
      p7zip
      pandoc
      pwgen
      qpdf # to remove passwords from PDF
      rsync
      spice
      sqlite
      umlet
      unar # universal unpacker
      util-linux
      unzip
      wget
      wmname
      yaml-language-server
      yarn-bash-completion
      zbar # to scan QR codes for pass-otp
    ]
    ++ [
      # Unfree packages
      unrar
      zip
    ]
    ++ [
      # Fonts
      aporetic
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
      jetbrains-mono
      liberation_ttf
      noto-fonts-emoji # recommended by Emacs
      roboto-mono
      ubuntu_font_family
      xorg.fontmiscmisc
    ]
  );
}
