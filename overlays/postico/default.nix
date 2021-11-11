{ pkgs, stdenv, fetchurl, unzip, lib }:

stdenv.mkDerivation rec {
  pname = "postico";
  version = "1.5.20";

  buildInputs = [ unzip ];
  sourceRoot = ".";
  phases = [ "unpackPhase" "installPhase" ];
  installPhase = ''
      mkdir -p "$out/Applications"
      cp -r "Postico.app" "$out/Applications/Postico.app"
    '';

  src = fetchurl {
    name = "postico-${version}.zip";
    url = "https://s3-eu-west-1.amazonaws.com/eggerapps-downloads/postico-${version}.zip";
    sha256 = "zt5Hw0BiCHzLdPP10q6rCJ53GbmB8T8UubKnn1wPD+k=";
  };

  meta = with pkgs.lib; {
    description = "A Modern PostgreSQL Client for the Mac";
    homepage = "https://eggerapps.at/postico";
    maintainers = [ "gpampara@gmail.com" ];
    platforms = platforms.darwin;
  };
}
