{
  description = "Home Manager configuration";

  inputs = {
    darwin = {
      url = "github:nix-darwin/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    emacs-overlay = {
      # url = "github:nix-community/emacs-overlay";
      url = "git+file:///Users/cassou/personal/projects/nix/emacs-overlay?ref=system";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nixpkgs-stable.follows = "nixpkgs-stable";
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

    # nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs.url = "git+file:///Users/cassou/personal/projects/nix/nixpkgs?ref=system";

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
            firefox-addons
            nixpkgs-firefox-darwin
            nixpkgs-stable
            ;
          pkgs = import nixpkgs { inherit system; };
          lib = nixpkgs.lib;
        });
    in
    {
      darwinConfigurations =
        let
          system = "aarch64-darwin";
          overlays = makeOverlays system;
          pkgs = import nixpkgs {
            inherit system overlays;
            config.allowUnfree = true;
          };
        in
        {
          macbook = darwin.lib.darwinSystem {
            inherit pkgs;

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
                    ./home-manager-config/common
                    ./home-manager-config/darwin
                  ];
                };
              }
            ];
          };
        };

      homeConfigurations =
        let
          system = "x86_64-linux";
          overlays = makeOverlays system;
          pkgs = import nixpkgs {
            inherit system overlays;
            config.allowUnfree = true;
          };
        in
        {
          "cassou" = home-manager.lib.homeManagerConfiguration {
            inherit pkgs;

            modules = [
              nix-index-database.homeModules.nix-index
              ./home-manager-config/common
              ./home-manager-config/forbidden-at-work.nix
              ./home-manager-config/non-nixos-linux.nix
              ./home-manager-config/linux
              # ./home-manager-config/linux-wm
              {
                home = {
                  homeDirectory = "/Users/cassou";
                  username = "cassou";
                };

                services.syncthing.enable = true;

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
