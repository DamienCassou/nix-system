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
    jwt-cli
    nodejs_20
    yarn
  ];

}
