{ pkgs, stdenv, fetchurl, undmg }:

stdenv.mkDerivation rec {
  pname = "brave";
  version = "1.20.110";

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
    sha256 = "dD3m4L9p99FTPSQA1K2sKR0UyY0OzWR7hXeRVfEyoWM=";
  };

  meta = with pkgs.lib; {
    description = "The Brave web browser";
    homepage = "https://brave.com";
    maintainers = [ "gpampara@gmail.com" ];
    platforms = platforms.darwin;
  };
}
