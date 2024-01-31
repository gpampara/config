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
    rev = "e924787e12e8a03194f36a113290ac11d6dc10f3";
    sha256 = "sha256-FNnkti4Ypw4RGIrIL9GtgjlYFMmOWZ2f8uQg/h3xesA=";
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
