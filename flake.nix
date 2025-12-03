{
  description = "Home Manager configuration";

  inputs = {
    darwin = {
      url = "github:nix-darwin/nix-darwin";
      # url = "git+file:///Users/cassou/personal/projects/nix/nix-darwin?ref=master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    emacs-overlay = {
      # url = "git+file:///Users/cassou/personal/projects/nix/emacs-overlay?ref=system";
      url = "github:nix-community/emacs-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nixpkgs-stable.follows = "nixpkgs-stable";
    };

    emacs-darwin = {
      # url = "git+file:///Users/cassou/personal/projects/nix/nix-darwin-emacs";
      url = "github:nix-giant/nix-darwin-emacs";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      # url = "git+file:///Users/cassou/personal/projects/nix/home-manager?ref=system";
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

    nixpkgs = {
      # url = "git+file:///Users/cassou/personal/projects/nix/nixpkgs?ref=system";
      url = "github:NixOS/nixpkgs/nixos-25.11";
    };

    nixpkgs-firefox-darwin = {
      url = "github:bandithedoge/nixpkgs-firefox-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-24.11";
  };

  outputs =
    {
      self,
      darwin,
      emacs-overlay,
      emacs-darwin,
      firefox-addons,
      home-manager,
      nix-index-database,
      nixGL,
      nixpkgs,
      nixpkgs-firefox-darwin,
      nixpkgs-stable,
      ...
    }:
    let
      makeOverlays =
        system:
        (import ./overlays.nix {
          inherit
            system
            emacs-overlay
            emacs-darwin
            firefox-addons
            nixGL
            nixpkgs-firefox-darwin
            nixpkgs-stable
            ;
          pkgs = import nixpkgs { inherit system; };
          lib = nixpkgs.lib;
        });
      makePkgs =
        system:
        import nixpkgs {
          inherit system;
          overlays = makeOverlays system;
          config.allowUnfree = true;
        };
    in
    {
      darwinConfigurations = {
        macbook = darwin.lib.darwinSystem {
          pkgs = makePkgs "aarch64-darwin";

          modules = [
            ./nix-darwin-config
            home-manager.darwinModules.home-manager
            {
              system.configurationRevision = self.rev or self.dirtyRev or null;
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users."cassou" = {
                imports = [
                  nix-index-database.homeModules.nix-index
                  ./machines/macbook
                ];
              };
            }
          ];
        };
      };

      homeConfigurations = {
        "cassou@framework" = home-manager.lib.homeManagerConfiguration {
          pkgs = makePkgs "x86_64-linux";

          modules = [
            nix-index-database.homeModules.nix-index
            ./machines/framework
          ];
        };
        "cassou@luz5" = home-manager.lib.homeManagerConfiguration {
          pkgs = makePkgs "x86_64-linux";

          modules = [
            nix-index-database.homeModules.nix-index
            ./machines/luz5
          ];
        };
        "cassou@raspberrypi" = home-manager.lib.homeManagerConfiguration {
          pkgs = makePkgs "aarch64-linux";
          modules = [
            nix-index-database.homeModules.nix-index
            ./machines/raspberrypi
          ];
        };
      };
    };
}
