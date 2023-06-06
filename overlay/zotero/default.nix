{ pkgs, stdenv, fetchurl, undmg }:

stdenv.mkDerivation rec {
  pname = "zotero";
  version = "6.0.18";

  buildInputs = [ undmg ];
  sourceRoot = ".";
  phases = [ "unpackPhase" "installPhase" ];
  installPhase = ''
      mkdir -p "$out/Applications"
      cp -r Zotero.app "$out/Applications/Zotero.app"
    '';

  src = fetchurl {
    name = "Zotero-${version}.dmg";
    url = "https://www.zotero.org/download/client/dl?channel=release&platform=mac&version=${version}";
    sha256 = "sha256-JjqINzpZs+OdFwfUYcSd/42cvfcDQTEjHJSUCmPaij0=";
  };

  meta = with pkgs.lib; {
    description = "Zotero: Your personal research assistant";
    homepage = "https://www.zotero.org/";
    maintainers = [ "gpampara@gmail.com" ];
    platforms = platforms.darwin;
  };
}
