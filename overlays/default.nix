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

  vagrant = prev.vagrant.overrideAttrs(oldAttrs: {
    postInstall =
      let
        # https://github.com/hashicorp/vagrant/issues/12583
        replacement = prev.fetchurl {
          url = "https://raw.githubusercontent.com/hashicorp/vagrant/42db2569e32a69e604634462b633bb14ca20709a/plugins/hosts/darwin/cap/path.rb";
          sha256 = "2YKz694IHzFgN0yUhIgMtwZDUGgTPhhWBC78tE7fV/k=";
        };
      in
      ''
        ${oldAttrs.postInstall}

        cp ${replacement} $out/lib/ruby/gems/2.7.0/gems/vagrant-2.2.19/plugins/hosts/darwin/cap/path.rb
      '';
  });

}
