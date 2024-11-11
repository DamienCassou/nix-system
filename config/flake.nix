{
  description = "Home Manager configuration";

  inputs = {
    emacs-overlay.url = "git+file:///home/cassou/Documents/projects/nix-system/emacs-overlay";

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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

    stylix.url = "git+file:///home/cassou/Documents/projects/nix-system/stylix";
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
            ./common
            ./non-nixos.nix
            ./linux
            ./linux-wm
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
