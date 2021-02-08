final: prev: {
  dmgPkgs = {
    brave = prev.callPackage ./brave {};
  };

  elm-language-server =
    (import ./elm-language-server { pkgs = prev; })."@elm-tooling/elm-language-server";
}
