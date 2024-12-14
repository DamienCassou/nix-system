{ ... }:
{
  imports = [
    ./desktop-entries.nix
  ];

  programs.bash.shellAliases = {
    "dnf-list" = "dnf repoquery --list";
    "dnf-provides" = "dnf repoquery --cacheonly --file";
  };
}
