final: prev: {

  dmgPkgs = {
    brave = prev.callPackage ./brave {};
    skim-pdf = prev.callPackage ./skim-pdf {};
    zotero = prev.callPackage ./zotero {};
  };

  elmPackages = prev.elmPackages // {
    elm-language-server = (import ./elm-language-server { pkgs = final; })."@elm-tooling/elm-language-server";
  };

  romcal = prev.callPackage ./romcal {};
}
