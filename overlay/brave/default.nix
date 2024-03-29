{ pkgs, stdenv, fetchurl, undmg, rsync }:

let
  braveVersion = import ./brave-version.info;
in
stdenv.mkDerivation {
  pname = "brave";
  version = braveVersion.version;
  sha256 = braveVersion.sha256;

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
    inherit (braveVersion) sha256;
    name = "Brave-Browser-x64-v${braveVersion.version}.dmg";
    url = "https://github.com/brave/brave-browser/releases/download/v${braveVersion.version}/Brave-Browser-x64.dmg";
  };

  meta = with pkgs.lib; {
    description = "The Brave web browser";
    homepage = "https://brave.com";
    maintainers = [ "gpampara@gmail.com" ];
    platforms = platforms.darwin;
  };
}
