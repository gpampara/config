{ pkgs, ... }: {

  imports = [
    ./emacs
  ];

  programs.emacs = {
    enable = true;
    package = pkgs.emacsPgtk;
    overrides = self: super: rec {
      tree-sitter-grammars = pkgs.stdenv.mkDerivation rec {
        name = "tree-sitter-grammars";
        version = "0.10.2";
        src = pkgs.fetchzip {
          name = "tree-sitter-grammars-macos-${version}.tar.gz";
          url = "https://github.com/ubolonton/tree-sitter-langs/releases/download/${version}/${src.name}";
          sha256 = "sha256-VKpmtKfzEayIF42tDzjeF98BGvN7XlEqUpE6JzrEdU4=";
          stripRoot = false;
        };
        installPhase = ''
          install -d $out/langs/bin
          install -m444 * $out/langs/bin
          echo -n $version > $out/langs/bin/BUNDLE-VERSION
        '';
      };

      tree-sitter-langs = super.tree-sitter-langs.overrideAttrs (oldAttrs: {
        postPatch =
          oldAttrs.postPatch or "" + ''
            substituteInPlace ./tree-sitter-langs-build.el \
            --replace "tree-sitter-langs-grammar-dir tree-sitter-langs--dir"  "tree-sitter-langs-grammar-dir \"${tree-sitter-grammars}/langs\""
          '';
      });

      org-ql = super.org-ql.overrideAttrs (oldAttrs: {
        patches = (oldAttrs.patches or []) ++ [
          (pkgs.fetchpatch {
            url = "https://patch-diff.githubusercontent.com/raw/alphapapa/org-ql/pull/216.patch";
            sha256 = "wL5XEB/EARsG/qnFaYKSDH0mbZhtxVCKtM1C29fNHWo=";
          })
        ];
      });
    };
  };

}
