{ pkgs, stdenv, fetchurl, unzip, lib }:

stdenv.mkDerivation rec {
  pname = "iterm2";
  version = "3.4.10";
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
    sha256 = "QKYhk1gt18VObyflCb24h+yGRRO1PUADdj2eFn5EqSE=";
  };

  meta = with pkgs.lib; {
    description = "iTerm2 is a replacement for Terminal and the successor to iTerm.";
    homepage = "https://iterm2.com";
    maintainers = [];
    platforms = platforms.darwin;
  };
}
