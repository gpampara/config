{ pkgs, stdenv, fetchurl, undmg }:

stdenv.mkDerivation rec {
  pname = "zotero";
  version = "5.0.95.3";

  buildInputs = [ undmg ];
  sourceRoot = ".";
  phases = [ "unpackPhase" "installPhase" ];
  installPhase = ''
      mkdir -p "$out/Applications"
      cp -r Zotero.app "$out/Applications/Zotero.app"
    '';

  src = fetchurl {
    name = "Zotero-${version}.dmg";
    url = "https://download.zotero.org/client/release/${version}/Zotero-${version}.dmg";
    sha256 = "183870408427771b17ecc4e7477a6798cf97a6604027d815bf39eb27e94e5afd";
  };

  meta = with pkgs.lib; {
    description = "Zotero: Your personal research assistant";
    homepage = "https://www.zotero.org/";
    maintainers = [ "gpampara@gmail.com" ];
    platforms = platforms.darwin;
  };
}
