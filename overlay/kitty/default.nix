{ pkgs, stdenv, fetchurl, undmg }:

let
  kittyMeta = import ./kitty-version.info;
in
stdenv.mkDerivation {
  pname = "kitty";
  version = kittyMeta.version;

  buildInputs = [ undmg ];
  sourceRoot = ".";
  phases = [ "unpackPhase" "installPhase" ];
  installPhase = ''
      mkdir -p "$out/Applications"
      cp -r kitty.app "$out/Applications/kitty.app"
    '';

  src = fetchurl {
    name = "kitty-${kittyMeta.version}.dmg";
    url = "https://github.com/kovidgoyal/kitty/releases/download/v${kittyMeta.version}/kitty-${kittyMeta.version}.dmg";
    sha256 = kittyMeta.sha256;
  };

  meta = with pkgs.lib; {
    description = "Cross-platform, fast, feature-rich, GPU based terminal";
    homepage = "https://sw.kovidgoyal.net/kitty";
    maintainers = [ "gpampara@gmail.com" ];
    platforms = platforms.darwin;
  };
}
