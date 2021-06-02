{ pkgs, stdenv, fetchurl, undmg }:

stdenv.mkDerivation rec {
  pname = "brave";
  version = "1.24.82";

  buildInputs = [ undmg ];
  sourceRoot = ".";
  phases = [ "unpackPhase" "installPhase" ];
  installPhase = ''
      mkdir -p "$out/Applications"
      cp -r "Brave Browser.app" "$out/Applications/Brave Browser.app"
    '';

  src = fetchurl {
    name = "Brave-Browser-x64-v${version}.dmg";
    url = "https://github.com/brave/brave-browser/releases/download/v${version}/Brave-Browser-x64.dmg";
    sha256 = "65SFL0EjGKKUJ/f4xbBSQzyqyS8Dj07zX/WXjIt7LQU=";
  };

  meta = with pkgs.lib; {
    description = "The Brave web browser";
    homepage = "https://brave.com";
    maintainers = [ "gpampara@gmail.com" ];
    platforms = platforms.darwin;
  };
}
