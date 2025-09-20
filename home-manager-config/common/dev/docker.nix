{ pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      docker-credential-helpers
      dockerfile-language-server
    ];

    # file = {
    #   ".docker/config.json".text = lib.strings.toJSON {
    #     credsStore = "pass";
    #     auths = {
    #       "ghcr.io" = { };
    #     };
    #   };
    # };
  };
}
