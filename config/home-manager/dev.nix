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
    nodePackages.prettier
    typescript # for eglot to work in JS project
    yarn
  ];

}
