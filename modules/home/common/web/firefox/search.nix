{ pkgs, ... }:
{
  search = {
    default = "ddg";
    force = true;
    engines = {
      "Amazon.fr".metaData.hidden = true;
      "google".metaData.hidden = true;
      "bing".metaData.hidden = true;

      "Nix Packages" = {
        urls = [
          {
            template = "https://search.nixos.org/packages";
            params = [
              {
                name = "type";
                value = "packages";
              }
              {
                name = "query";
                value = "{searchTerms}";
              }
            ];
          }
        ];

        icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
        definedAliases = [ "@np" ];
      };
    };
  };
}
