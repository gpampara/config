final: prev: {
  dmgPkgs = {
    brave = prev.callPackage ./brave {};
    element = prev.callPackage ./element {};
    skim-pdf = prev.callPackage ./skim-pdf {};
    zotero = prev.callPackage ./zotero {};
  };

  elm-language-server =
    (import ./elm-language-server { pkgs = prev; })."@elm-tooling/elm-language-server";
}
