{ pkgs, stdenv, fetchurl, undmg }:

stdenv.mkDerivation rec {
  pname = "element";
  version = "1.7.28";

  buildInputs = [ undmg ];
  sourceRoot = ".";
  phases = [ "unpackPhase" "installPhase" ];
  installPhase = ''
    mkdir -p "$out/Applications"
    cp -r "Element.app" "$out/Applications/Element.app"
  '';

  src = fetchurl {
    name = "Element-${version}.dmg";
    url = "https://packages.riot.im/desktop/install/macos/Element-${version}.dmg";
    sha256 = "ocS+5C67LQ1M/vNCO/ClOi+817qt8EkPjNlwf8lj3TE=";
  };

  meta = with pkgs.lib; {
    description = "A feature-rich client for Matrix.org";
    homepage = "https://element.io/";
    license = licenses.asl20;
    maintainers = [ "gpampara@gmail.com" ];
    platforms = platforms.darwin;
  };
}
