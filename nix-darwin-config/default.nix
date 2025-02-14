{ ... }:
{
  nix.settings = {
    experimental-features = "nix-command flakes";
    trusted-users = [ "cassou" ];
  };

  system.stateVersion = 6;
  nixpkgs.hostPlatform = "aarch64-darwin";
  system.defaults.dock.autohide = true;
  users.users.cassou = {
    home = "/Users/cassou";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPNt/RcAiO+zgCvPUBXGHwPRr1qpufb/+tZlSab5D0cM cardno:000F_F29888AB"
    ];
  };
}
