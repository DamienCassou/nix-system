{ pkgs, ... }:

{
  programs.bun = {
    enable = true;
  };

  home.packages = with pkgs; [
    eslint_d
    jwt-cli
    git-crypt
    nodejs_22
    nodePackages.prettier
    typescript # for eglot to work in JS project
    virt-manager
    vscode
    yarn
  ];

}
