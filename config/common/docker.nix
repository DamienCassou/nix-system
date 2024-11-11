{ lib, pkgs, ... }:
{
  home = {
    packages = [ pkgs.docker-credential-helpers ];
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
