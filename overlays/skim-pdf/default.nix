{ pkgs, stdenv, fetchurl, undmg }:

stdenv.mkDerivation rec {
  pname = "skim";
  version = "1.6";

  buildInputs = [ undmg ];
  sourceRoot = ".";
  phases = [ "unpackPhase" "installPhase" ];
  installPhase = ''
      mkdir -p "$out/Applications"
      cp -r "Skim.app" "$out/Applications/Skim.app"
    '';

  src = fetchurl {
    name = "Skim-app-${version}.dmg";
    url = "https://downloads.sourceforge.net/skim-app/Skim/Skim-${version}/Skim-${version}.dmg";
    sha256 = "9cea2e92986dc97b611272636daced490231432d24b34594f4e1f4554a248dee";
  };

  meta = with pkgs.lib; {
    description = "The Skim PDF viewer";
    homepage = "https://sourceforge.net/projects/skim-app";
    maintainers = [ "gpampara@gmail.com" ];
    platforms = platforms.darwin;
  };
}
