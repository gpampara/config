final: prev: rec {

  dmgPkgs = {
    brave = prev.callPackage ./brave {};
    skim-pdf = prev.callPackage ./skim-pdf {};
    zotero = prev.callPackage ./zotero {};
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

 # This overlay is due to https://github.com/NixOS/nixpkgs/pull/315141 not yet being merged in unstable
 # haskellPackages = prev.haskellPackages.override {
 #   overrides = hself: hsuper:
 #     {
 #       crypton-x509-system = final.pkgs.haskell.lib.compose.overrideCabal (drv:
 #         prev.pkgs.lib.optionalAttrs (!prev.pkgs.stdenv.cc.nativeLibc) {
 #           postPatch = ''
 #             substituteInPlace System/X509/MacOS.hs --replace security /usr/bin/security
 #           '' + (drv.postPatch or "");
 #         }) prev.haskellPackages.crypton-x509-system;
 #     };
 # };

}
