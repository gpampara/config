{ pkgs, stdenv, fetchurl, undmg, rsync }:

stdenv.mkDerivation rec {
  pname = "brave";
  version = (import ./brave-version.info).version;
  sha256 = "sha256-4LT13a+o5Hi18Oj9NujgQnGOjO85QAXv7bfLbNfqD5I=";

  buildInputs = [ undmg rsync ];
  sourceRoot = ".";
  phases = [ "unpackPhase" "installPhase" ];
  installPhase = ''
      mkdir -p "$out/Applications"
      ls "Brave Browser.app/Contents/Frameworks/Brave Browser Framework.framework/Frameworks/Sparkle.framework/Versions/A/Resources"
      rm -rf "Brave Browser.app/Contents/Frameworks/Brave Browser Framework.framework/Frameworks/Sparkle.framework/Versions/A/Resources/Autoupdate.app"
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
