{
  config,
  lib,
  pkgs,
  ...
}:

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
      FINSIT_GITHUB = "$(cat ${lib.elemAt config.nix.nixPath 0}/secrets/FINSIT_GITHUB)";

      JFROG_API_KEY = "$(pass-show-password wk/jfrog.io/token)";

      ESLINT_USE_FLAT_CONFIG = "true";
    };
  };
}
