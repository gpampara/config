{ pkgs, stdenv, fetchurl, undmg }:

stdenv.mkDerivation rec {
  pname = "brave";
  version = "1.31.88";
  sha256 = "ZVFX7ynyz9S6RMCT+hXCtLEdyEsYAfOWIEcVrAA13LI=";

  buildInputs = [ undmg ];
  sourceRoot = ".";
  phases = [ "unpackPhase" "installPhase" ];
  installPhase = ''
      mkdir -p "$out/Applications"
      cp -r "Brave Browser.app" "$out/Applications/Brave Browser.app"
    '';

  src = fetchurl {
    inherit sha256;
    name = "Brave-Browser-x64-v${version}.dmg";
    url = "https://github.com/brave/brave-browser/releases/download/v${version}/Brave-Browser-x64.dmg";
  };

  meta = with pkgs.lib; {
    description = "The Brave web browser";
    homepage = "https://brave.com";
    maintainers = [ "gpampara@gmail.com" ];
    platforms = platforms.darwin;
  };
}
