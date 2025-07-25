{ config, pkgs, ... }:

{
  imports = [
    ./docker.nix
  ];

  programs = {
    bun.enable = true;
  };

  home.packages = with pkgs; [
    bash-language-server
    couchdb-dump
    devenv
    eslint_d
    inetutils
    git-crypt
    jwt-cli
    keep-sorted
    lint-staged
    nodePackages.prettier
    nodePackages.typescript
    nodejs_22
    omnisharp-roslyn # for C# development in Monitor
    otel-desktop-viewer
    patch
    patchutils
    pnpm
    shellcheck
    treefmt
    typescript # for eglot to work in JS project
    typescript-language-server
    vscode-js-debug
    yarn
  ];

  home = {
    extraOutputsToInstall = [ "devdoc" ];

    sessionPath = [
      config.home.sessionVariables.DOTNET_ROOT
      "${config.home.sessionVariables.DOTNET_ROOT}/tools"
    ];

    sessionVariables = {
      CLEAR_CONSOLE = "false";

      # Prevent .NET Core from sending usage statistics:
      DOTNET_CLI_TELEMETRY_OPTOUT = "true";

      # Tell dotnet where to find the installations
      DOTNET_ROOT = "${config.home.homeDirectory}/.dotnet";

      # I need this variable to be accessible from desktop
      # applications, not only from shell sessions. Using
      # pass-show-password doesn't seem to work for desktop
      # applications, maybe because gpg isn't ready when the session
      # variables are initially set.
      # The error message I get is:
      # > Value: gpg: public key decryption failed: No such file or directory
      # > gpg: decryption failed: No such file or directory
      FINSIT_GITHUB = builtins.readFile ../../../secrets/FINSIT_GITHUB;
      JFROG_API_KEY = builtins.readFile ../../../secrets/JFROG_API_KEY;

      ESLINT_USE_FLAT_CONFIG = "true";
    };
  };
}
