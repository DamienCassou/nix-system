{
  description = "Home Manager configuration";

  inputs = {
    emacs-overlay.url = "git+file:///home/cassou/Documents/projects/nix-system/emacs-overlay";

    home-manager = {
      url = "git+file:///home/cassou/Documents/projects/nix-system/home-manager";
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

    nixpkgs.url = "git+file:///home/cassou/Documents/projects/nix-system/nixpkgs";

    rycee-nur-expressions = {
      url = "git+file:///home/cassou/Documents/projects/nix-system/rycee-nur-expressions";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix.url = "git+file:///home/cassou/Documents/projects/nix-system/stylix";
  };

  outputs =
    {
      emacs-overlay,
      home-manager,
      nix-index-database,
      nixGL,
      nixpkgs,
      rycee-nur-expressions,
      stylix,
      ...
    }:
    let
      system = "x86_64-linux";
      overlays = [
        emacs-overlay.overlay
        (_: _: { firefox-addons = rycee-nur-expressions.firefox-addons; })
      ];
      pkgs = import nixpkgs {
        inherit system overlays;
        config.allowUnfree = true;
      };
    in
    {
      homeConfigurations = {
        cassou = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;

          modules = [
            nix-index-database.hmModules.nix-index
            stylix.homeManagerModules.stylix
            ./non-nixos.nix
            {
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
