final: prev: {

  dmgPkgs = {
    brave = prev.callPackage ./brave {};
    #element = prev.callPackage ./element {};
    iina = prev.callPackage ./iina {};
    postico = prev.callPackage ./postico {};
    skim-pdf = prev.callPackage ./skim-pdf {};
    zotero = prev.callPackage ./zotero {};
    kitty = prev.callPackage ./kitty {};
  };

  elmPackages = prev.elmPackages // {
    elm-language-server = (import ./elm-language-server { pkgs = final; })."@elm-tooling/elm-language-server";
  };

  romcal = prev.callPackage ./romcal {};

  git-ps-rs = prev.callPackage ./git-ps-rs {};
}
