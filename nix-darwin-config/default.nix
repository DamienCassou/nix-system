{ ... }:
{
  nix.settings = {
    experimental-features = "nix-command flakes";
    trusted-users = [ "cassou" ];
  };

  nixpkgs.hostPlatform = "aarch64-darwin";

  programs = {
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };

  services = {
    emacs = {
      enable = true;
    };
  };

  system = {
    defaults.dock.autohide = true;
    stateVersion = 6;
  };

  users.users.cassou = {
    home = "/Users/cassou";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPNt/RcAiO+zgCvPUBXGHwPRr1qpufb/+tZlSab5D0cM cardno:000F_F29888AB"
    ];
  };
}
