{ lib, pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      docker-credential-helpers
      nodePackages.dockerfile-language-server-nodejs
    ];

    file = {
      ".docker/config.json".text = lib.strings.toJSON {
        credsStore = "pass";
        auths = {
          "ghcr.io" = { };
        };
      };
    };
  };
}
