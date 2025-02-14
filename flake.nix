{
  description = "Home Manager configuration";

  inputs = {
    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    emacs-overlay = {
      url = "github:nix-community/emacs-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nixpkgs-stable.follows = "nixpkgs-stable";
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
    # nixpkgs.url = "git+file:///home/cassou/personal/projects/nix/nixpkgs?ref=system";

    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-24.11";

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs =
    {
      self,
      darwin,
      emacs-overlay,
      firefox-addons,
      home-manager,
      nix-index-database,
      nixGL,
      nixpkgs,
      nixpkgs-stable,
      stylix,
      ...
    }:
    let
      system = "x86_64-linux";
      overlays = [
        emacs-overlay.overlay
        (_: _: { firefox-addons = firefox-addons.packages.${system}; })
        (_: _: {
          stable = import nixpkgs-stable {
            inherit system overlays;
            config.allowUnfree = true;
          };
        })
      ];
      pkgs = import nixpkgs {
        inherit system overlays;
        config.allowUnfree = true;
      };
    in
    {
      darwinConfigurations = {
        macbook = darwin.lib.darwinSystem {
          modules = [
            ./nix-darwin-config
            home-manager.darwinModules.home-manager
            {
              system.configurationRevision = self.rev or self.dirtyRev or null;
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users."cassou" = {
                imports = [
                  nix-index-database.hmModules.nix-index
                  stylix.homeManagerModules.stylix
                  ./home-manager-config/common
                ];
              };
            }
          ];
        };
      };

      homeConfigurations = {
        "cassou@luz5" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;

          modules = [
            nix-index-database.hmModules.nix-index
            stylix.homeManagerModules.stylix
            ./home-manager-config/common
            ./home-manager-config/forbidden-at-work.nix
            ./home-manager-config/non-nixos.nix
            ./home-manager-config/linux
            ./home-manager-config/linux-wm
            {
              home = {
                homeDirectory = "/home/cassou";
                username = "cassou";
              };

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
