{
  stdenv,
  lib,
  python3Packages,
  tk,
  makeWrapper,
  ...
}:

stdenv.mkDerivation {
  name = "co2-sensor";
  src = ./client.py;
  dontUnpack = true;

  buildInputs = with python3Packages; [
    pyserial
    numpy
    tkinter
    matplotlib
  ];

  nativeBuildInputs = [ makeWrapper ];

  installPhase = ''
    mkdir -p $out/bin
    install -D $src $out/bin/$name
    wrapProgram $out/bin/$name \
      --prefix PYTHONPATH : "$PYTHONPATH" \
      --set TK_LIBRARY "${tk}/lib/${tk.libPrefix}"
  '';

  meta = with lib; {
    description = "A script monitoring my CO2 sensor";
    license = licenses.free;
    platforms = platforms.all;
    mainProgram = "co2-sensor";
  };
}
