{ pkgs, stdenv, fetchurl, undmg }:

stdenv.mkDerivation rec {
  pname = "element";
  version = "1.7.20";

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
    sha256 = "HgnUrhUP8oLxOOqPvZlb3LUbtwpliXhY044lN9HF4dk=";
  };

  meta = with pkgs.lib; {
    description = "A feature-rich client for Matrix.org";
    homepage = "https://element.io/";
    license = licenses.asl20;
    maintainers = [ "gpampara@gmail.com" ];
    platforms = platforms.darwin;
  };
}
