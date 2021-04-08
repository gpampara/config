final: prev: {
  dmgPkgs = {
    brave = prev.callPackage ./brave {};
    element = prev.callPackage ./element {};
    iina = prev.callPackage ./iina {};
    iterm2 = prev.callPackage ./iterm2 {};
    postico = prev.callPackage ./postico {};
    skim-pdf = prev.callPackage ./skim-pdf {};
    slack = prev.callPackage ./slack {};
    zotero = prev.callPackage ./zotero {};
  };
}
