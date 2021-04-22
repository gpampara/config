{ pkgs, stdenv, fetchurl, undmg }:

stdenv.mkDerivation rec {
  pname = "skim";
  version = "1.6.3";

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
    sha256 = "Hf/mVl+pst1oQ5w0f9mwKy6jDvWHUyjhvT9zKCf6T+Y=";
  };

  meta = with pkgs.lib; {
    description = "The Skim PDF viewer";
    homepage = "https://sourceforge.net/projects/skim-app";
    maintainers = [ "gpampara@gmail.com" ];
    platforms = platforms.darwin;
  };
}
