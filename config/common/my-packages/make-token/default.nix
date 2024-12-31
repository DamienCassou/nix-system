{ pkgs, ... }:

pkgs.buildNpmPackage {
  pname = "make-token";
  version = "1.0.0";

  src = ./.;

  npmDepsHash = "sha256-ph+2+LJZ8yKUzi1xeqDTtT/Bdr93kFehy8REdueAhhM=";

  dontNpmBuild = true;
}
