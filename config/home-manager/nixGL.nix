{ pkgs, ... }:
{
  nixGL = {
    packages = (pkgs.callPackage ../../nixGL { });
    installScripts = [ "mesa" ];
  };
}
