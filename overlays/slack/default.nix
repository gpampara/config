{ pkgs, stdenv, fetchurl, undmg }:

stdenv.mkDerivation rec {
  pname = "slack";
  version = "4.14.0";

  buildInputs = [ undmg ];
  sourceRoot = ".";
  phases = [ "unpackPhase" "installPhase" ];
  installPhase = ''
      mkdir -p "$out/Applications"
      cp -r "Slack.app" "$out/Applications/Slack.app"
    '';

  src = fetchurl {
    name = "Slack-v${version}-macOS.dmg";
    url = "https://slack.com/ssb/download-osx-universal";
    sha256 = "fd4f0c433f5338f5c8dfdc4d070f933ece67ec623776c381a6f16a9e0c3b64ed";
  };

  meta = with pkgs.lib; {
    description = "Slack Business Chat";
    homepage = "https://slack.com";
    maintainers = [ "gpampara@gmail.com" ];
    platforms = platforms.darwin;
  };
}
