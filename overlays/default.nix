final: prev: {
  dmgPkgs = {
    brave = prev.callPackage ./brave {};
    element = prev.callPackage ./element {};
    skim-pdf = prev.callPackage ./skim-pdf {};
    zotero = prev.callPackage ./zotero {};
  };
}
