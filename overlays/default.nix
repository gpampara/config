final: prev: {
  dmgPkgs = {
    brave = prev.callPackage ./brave {};
    zotero = prev.callPackage ./zotero {};
  };

  elm-language-server =
    (import ./elm-language-server { pkgs = prev; })."@elm-tooling/elm-language-server";
}
