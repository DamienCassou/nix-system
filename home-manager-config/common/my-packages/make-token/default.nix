{ pkgs, ... }:

pkgs.buildNpmPackage {
  pname = "make-token";
  version = "1.0.0";

  src = ./.;

  npmDepsHash = "sha256-gSzdAviu1En13hHCmtLZbteHUOqaoRiqqnroPDMr3z0=";

  dontNpmBuild = true;

  nativeBuildInputs = [ pkgs.makeWrapper ];

  postInstall = ''
    wrapProgram $out/bin/make-token --prefix PATH : ${pkgs.xsel}/bin
    wrapProgram $out/bin/get-secret --prefix PATH : ${pkgs.xsel}/bin
  '';
}
