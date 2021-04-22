{ pkgs, stdenv, fetchurl, unzip, lib }:

stdenv.mkDerivation rec {
  pname = "iterm2";
  version = "3.4.5";
  underscoreVersion = lib.replaceStrings ["."] ["_"] version;

  buildInputs = [ unzip ];
  sourceRoot = ".";
  phases = [ "unpackPhase" "installPhase" ];
  installPhase = ''
      mkdir -p "$out/Applications"
      cp -r "iTerm.app" "$out/Applications/iTerm.app"
    '';

  src = fetchurl {
    name = "iTerm2-${underscoreVersion}.zip";
    url = "https://iterm2.com/downloads/stable/iTerm2-${underscoreVersion}.zip";
    sha256 = "50A9zFsIlWoUg7Xe/qO3X7gcPeQ0XaYADjrUphiLR98=";
  };

  meta = with pkgs.lib; {
    description = "The modern media player for macOS";
    homepage = "https://iina.io";
    maintainers = [ "gpampara@gmail.com" ];
    platforms = platforms.darwin;
  };
}
