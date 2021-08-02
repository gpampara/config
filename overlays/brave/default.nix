{ pkgs, stdenv, fetchurl, undmg }:

stdenv.mkDerivation rec {
  pname = "brave";
  version = "1.27.109";
  sha256 = "7IeQiz7HTY4FfDQKBBfd4/3Lbs8N2R8gp6x0Ux4NNLw=";

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
