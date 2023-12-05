final: prev: rec {

  dmgPkgs = {
    brave = prev.callPackage ./brave {};
    skim-pdf = prev.callPackage ./skim-pdf {};
    zotero = prev.callPackage ./zotero {};
  };

  elmPackages = prev.elmPackages // {
    elm-language-server = (import ./elm-language-server { pkgs = final; })."@elm-tooling/elm-language-server";
  };

  nodePackages = prev.nodePackages // {
    astro-language-server = (import ./astro-language-server { pkgs = final; })."@astrojs/language-server";
  };

  romcal = prev.callPackage ./romcal {};


  tree-sitter-astro = {
    url = "https://github.com/virchau13/tree-sitter-astro";
    rev = "e122a8fcd07e808a7b873bfadc2667834067daf1";
    sha256 = "sha256-iCVRTX2fMW1g40rHcJEwwE+tfwun+reIaj5y4AFgmKk=";
    fetchLFS = false;
    fetchSubmodules = false;
    deepClone = false;
    leaveDotGit = false;
  };

  tree-sitter-grammars =
    prev.tree-sitter-grammars // {
      tree-sitter-astro = prev.tree-sitter.buildGrammar
        {
          language = "astro";
          version = "0.0.0+rev=e122a8f";
          src = prev.fetchFromGitHub tree-sitter-astro;
          meta.homepage = "https://github.com/virchau13/tree-sitter-astro";
        };
    };

  tree-sitter = prev.tree-sitter.override {
    extraGrammars = {
      inherit tree-sitter-astro;
    };
  };
}
