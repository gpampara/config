final: prev: {
  dmgPkgs = {
    brave = prev.callPackage ./brave {};
    element = prev.callPackage ./element {};
    iina = prev.callPackage ./iina {};
    skim-pdf = prev.callPackage ./skim-pdf {};
    slack = prev.callPackage ./slack {};
    zotero = prev.callPackage ./zotero {};
  };
}
