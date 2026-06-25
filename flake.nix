{
  description = "Home Manager configuration";

  inputs = {
    darwin = {
      url = "github:nix-darwin/nix-darwin/nix-darwin-26.05";
      # url = "git+file:///Users/cassou/personal/projects/nix/nix-darwin?ref=master";
      inputs.nixpkgs.follows = "nixpkgs-stable-darwin";
    };

    emacs-overlay = {
      # url = "git+file:///Users/cassou/personal/projects/nix/emacs-overlay?ref=system";
      url = "github:nix-community/emacs-overlay";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
      inputs.nixpkgs-stable.follows = "nixpkgs-stable";
    };

    emacs-darwin = {
      # url = "git+file:///Users/cassou/personal/projects/nix/nix-darwin-emacs";
      url = "github:nix-giant/nix-darwin-emacs";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };

    home-manager = {
      # url = "git+file:///Users/cassou/personal/projects/nix/home-manager?ref=system";
      url = "github:nix-community/home-manager";
      # url = "github:DamienCassou/home-manager/system";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };

    nixGL = {
      url = "github:nix-community/nixGL";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };

    nixos-hardware = {
      url = "github:NixOS/nixos-hardware/master";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };

    nixpkgs-stable = {
      # url = "git+file:///Users/cassou/personal/projects/nix/nixpkgs?ref=system";
      url = "github:NixOS/nixpkgs/release-26.05";
      # url = "github:DamienCassou/nixpkgs/system";
    };

    nixpkgs-stable-darwin = {
      # url = "git+file:///Users/cassou/personal/projects/nix/nixpkgs?ref=system";
      url = "github:NixOS/nixpkgs/nixpkgs-26.05-darwin";
      # url = "github:DamienCassou/nixpkgs/system";
    };

    nixpkgs-unstable = {
      # url = "git+file:///Users/cassou/personal/projects/nix/nixpkgs?ref=system";
      url = "github:NixOS/nixpkgs/nixos-unstable";
      # url = "github:DamienCassou/nixpkgs/system";
    };

    nixpkgs-firefox-darwin = {
      url = "github:bandithedoge/nixpkgs-firefox-darwin";
      inputs.nixpkgs.follows = "nixpkgs-stable-darwin";
    };
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
      nixos-hardware,
      nixpkgs-firefox-darwin,
      nixpkgs-stable,
      nixpkgs-stable-darwin,
      ...
    }:
    let
      makeOverlays =
        nixpkgs: system:
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
        nixpkgs: system:
        import nixpkgs {
          inherit system;
          overlays = makeOverlays nixpkgs-stable system;
          config.allowUnfree = true;
        };
    in
    {
      darwinConfigurations = {
        ancizan = darwin.lib.darwinSystem {
          pkgs = makePkgs nixpkgs-stable-darwin "aarch64-darwin";

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
          pkgs = makePkgs nixpkgs-stable "x86_64-linux";

          modules = [
            nix-index-database.homeModules.nix-index
            ./machines/framework
          ];
        };
      };

      nixosConfigurations = {
        "luz5" = nixpkgs-stable.lib.nixosSystem {
          pkgs = makePkgs nixpkgs-stable "x86_64-linux";

          modules = [
            ./machines/luz5/nixos
            nixos-hardware.nixosModules.lenovo-thinkpad-t490
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.cassou =
                { ... }:
                {
                  imports = [
                    nix-index-database.homeModules.nix-index
                    ./machines/luz5/home-manager
                  ];
                };
            }
          ];
        };
        "raspberrypi" = nixpkgs-stable.lib.nixosSystem {
          pkgs = makePkgs nixpkgs-stable "aarch64-linux";

          modules = [
            ./machines/raspberrypi/nixos
            # nixos-hardware.nixosModules.raspberry-pi-4
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.cassou =
                { ... }:
                {
                  imports = [
                    nix-index-database.homeModules.nix-index
                    ./machines/raspberrypi/home-manager
                  ];
                };
            }
          ];
        };
        "pepite" = nixpkgs-stable.lib.nixosSystem {
          pkgs = makePkgs nixpkgs-stable "x86_64-linux";

          modules = [
            ./machines/pepite/nixos
            nixos-hardware.nixosModules.lenovo-thinkpad-t480s
          ];
        };
      };
    };
}
