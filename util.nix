{ stdenv } : {

  forSystem = { linux, darwin }:
    if stdenv.isDarwin then darwin else linux;

}
