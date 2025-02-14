{ pkgs, ... }: {
  search = {
    default = "DuckDuckGo";
    force = true;
    engines = {
      "Amazon.fr".metaData.hidden = true;
      "Google".metaData.hidden = true;
      "Bing".metaData.hidden = true;

      "Nix Packages" = {
        urls = [{
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
        }];

        icon =
          "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
        definedAliases = [ "@np" ];
      };
    };
  };
}
