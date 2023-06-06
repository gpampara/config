{ pkgs, stdenv, fetchurl, undmg }:

let
  version = "1.6.13";
  sha256 = "sha256-ppZ2bCGbovdIe/YFS2yUr3i9SenUp6IQ/ABxk++FxvE=";
in
stdenv.mkDerivation rec {
  inherit version;
  pname = "skim";

  buildInputs = [ undmg ];
  sourceRoot = ".";
  phases = [ "unpackPhase" "installPhase" ];
  installPhase = ''
      mkdir -p "$out/Applications"
      cp -r "Skim.app" "$out/Applications/Skim.app"
    '';

  src = fetchurl {
    inherit sha256;
    name = "Skim-app-${version}.dmg";
    url = "https://downloads.sourceforge.net/skim-app/Skim/Skim-${version}/Skim-${version}.dmg";
  };

  meta = with pkgs.lib; {
    description = "The Skim PDF viewer";
    homepage = "https://sourceforge.net/projects/skim-app";
    maintainers = [ "gpampara@gmail.com" ];
    platforms = platforms.darwin;
  };
}
