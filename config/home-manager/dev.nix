{ pkgs, ... }:

{
  imports = [
    ./bash.nix
    ./emacs.nix
    ./git.nix
    ./gpg.nix
    ./ssh.nix
  ];

  programs.bun = {
    enable = true;
  };

  home.packages = with pkgs; [
    eslint_d
    jwt-cli
    nodejs_20
    typescript # for eglot to work in JS project
    yarn
  ];

}
