{ pkgs, ... }: {

  imports = [
    ./emacs
  ];

  programs.emacs =
    let
      patchedEmacsPgtk = pkgs.emacsPgtk.overrideAttrs(oldAttrs: {
        # https://lists.gnu.org/archive/html/emacs-devel/2021-11/msg00672.html
        patched = oldAttrs.patches ++ [ ./0001-Use-posix_spawn-if-possible-on-Darwin.patch ];
      });
    in
      {
    enable = true;
    package = patchedEmacsPgtk; #pkgs.emacsPgtk;
    overrides = self: super: rec {
      tree-sitter-grammars = pkgs.stdenv.mkDerivation rec {
        name = "tree-sitter-grammars";
        version = "0.10.12";
        src = pkgs.fetchzip {
          name = "tree-sitter-grammars-macos-${version}.tar.gz";
          url = "https://github.com/ubolonton/tree-sitter-langs/releases/download/${version}/${src.name}";
          sha256 = "sha256-VxAwQdCNtjiABkeJDwzoTLmreZpFEeOfwMz/fj7pAxQ=";
          stripRoot = false;
        };
        buildPhase = ''
          mkdir -p $out/langs/bin
          echo -n $version > $out/langs/bin/BUNDLE-VERSION
        '';
        installPhase = ''
          install -d $out/langs/bin
          install -m444 * $out/langs/bin
        '';
      };

      tree-sitter-langs = super.tree-sitter-langs.overrideAttrs (oldAttrs: {
        postPatch =
          oldAttrs.postPatch or "" + ''
            substituteInPlace ./tree-sitter-langs-build.el \
            --replace "tree-sitter-langs-grammar-dir tree-sitter-langs--dir"  "tree-sitter-langs-grammar-dir \"${tree-sitter-grammars}/langs\""
          '';
      });
    };
  };

}
