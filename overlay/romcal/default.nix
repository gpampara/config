{ lib, buildNpmPackage }:

buildNpmPackage rec {
  pname = "romcal";
  version = "";

  src = builtins.fetchFromGithub {
    owner = pname;
    repo = pname;
    rev = "2f9a0c5f96d99a5505298d03e4a3ad902cb6bf43";
    hash = "";
  };

  npmHashDeps = "";

  meta = {
    description = "JavaScript library that generates liturgical calendars of the Roman Rite of the Catholic Church.";
    homepage = "https://romcal.js.org";
    license = lib.licenses.mit;
    maintainers = "gpampara@gmail.com";
  };
}
