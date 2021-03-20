{ pkgs, stdenv, fetchurl, undmg }:

stdenv.mkDerivation rec {
  pname = "iina";
  version = "1.1.2";

  buildInputs = [ undmg ];
  sourceRoot = ".";
  phases = [ "unpackPhase" "installPhase" ];
  installPhase = ''
      mkdir -p "$out/Applications"
      cp -r "IINA.app" "$out/Applications/IINA.app"
    '';

  src = fetchurl {
    name = "IINA.v${version}.dmg";
    url = "https://dl-portal.iina.io/IINA.v${version}.dmg";
    sha256 = "eD/xZcc4Och8+f1fRBi4cTEGPDvneryU38oFhaqZK5g=";
  };

  meta = with pkgs.lib; {
    description = "The modern media player for macOS";
    homepage = "https://iina.io";
    maintainers = [ "gpampara@gmail.com" ];
    platforms = platforms.darwin;
  };
}
