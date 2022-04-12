{stdenv, lib}:

# From http://www.romcal.net/

stdenv.mkDerivation {
  name = "romcal";
  src = builtins.fetchTarball {
    url    = "http://www.romcal.net/romcal-v6.tar";
    sha256 = "sha256:01ad3n7i0aki1bsg2a5ayms623wgy1r3j3zsxrj4lg1d28q6vpf4";
  };
}
