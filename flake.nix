{
  description = "Home Manager configuration";

  inputs = {
    emacs-overlay = {
      url = "github:nix-community/emacs-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixGL = {
      url = "github:nix-community/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs =
    {
      emacs-overlay,
      firefox-addons,
      home-manager,
      nix-index-database,
      nixGL,
      nixpkgs,
      stylix,
      ...
    }:
    let
      system = "x86_64-linux";
      overlays = [
        emacs-overlay.overlay
        (_: _: { firefox-addons = firefox-addons.packages.${system}; })
      ];
      pkgs = import nixpkgs {
        inherit system overlays;
        config.allowUnfree = true;
      };
    in
    {
      homeConfigurations = {
        "cassou@luz5" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;

          modules = [
            nix-index-database.hmModules.nix-index
            stylix.homeManagerModules.stylix
            ./config/common
            ./config/forbidden-at-work.nix
            ./config/non-nixos.nix
            ./config/linux
            ./config/linux-wm
            {
              my.window-management.enable = true;

              nixGL = {
                packages = nixGL.packages;
                installScripts = [ "mesa" ];
              };
            }
          ];
        };
      };
    };
}

# Local Variables:
# eval: (my/eglot-format-on-save-mode)
# eval: (my/eglot-ensure)
# End:
