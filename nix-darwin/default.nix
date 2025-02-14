{...}:
{
  nix.settings.experimental-features = "nix-command flakes";
  system.stateVersion = 6;
  nixpkgs.hostPlatform = "aarch64-darwin";
  system.defaults.dock.autohide = true;
  users.users.cassou.home = "/Users/cassou";
}
