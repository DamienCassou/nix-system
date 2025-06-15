# Top-level flake glue to get our configuration working
{ inputs, ... }:

{
  imports = [
    inputs.nixos-unified.flakeModules.default
    inputs.nixos-unified.flakeModules.autoWire
  ];

  perSystem =
    {
      self',
      pkgs,
      system,
      ...
    }:
    {
      # For 'nix fmt'
      # formatter = pkgs.nixpkgs-fmt;

      # Enables 'nix run' to activate.
      packages.default = self'.packages.activate;

      _module.args.pkgs = (
        import inputs.nixpkgs {
          inherit system;
          overlays = [
            (final: prev: {
              stable = "foo";
            })
          ];
          # config = { };
        }
      );
    };
}
