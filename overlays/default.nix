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

  elmPackages = prev.elmPackages // {
    elm-language-server = (import ./elm-language-server { pkgs = final; })."@elm-tooling/elm-language-server";
  };

  romcal = prev.callPackage ./romcal {};

  git-ps-rs = prev.callPackage ./git-ps-rs {};
}
