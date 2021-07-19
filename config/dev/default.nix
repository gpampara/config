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
        version = "0.10.0";
        src = pkgs.fetchzip {
          name = "tree-sitter-grammars-macos-${version}.tar.gz";
          url = "https://github.com/ubolonton/tree-sitter-langs/releases/download/${version}/${src.name}";
          sha256 = "sha256-m5WH9TYIn+ldMM/6bWpSYPMAGmPgCZhgiUCVIUb+Fd0=";
          stripRoot = false;
        };
        installPhase = ''
          install -d $out/langs/bin
          install -m444 * $out/langs/bin
          echo -n $version > $out/langs/bin/BUNDLE-VERSION
        '';
      };

      tree-sitter-langs = super.emacs.pkgs.tree-sitter-langs.overrideAttrs (oldAttrs: {
        postPatch = oldAttrs.postPatch or "" + ''
        substituteInPlace ./tree-sitter-langs-build.el \
        --replace "tree-sitter-langs-grammar-dir tree-sitter-langs--dir"  "tree-sitter-langs-grammar-dir \"${tree-sitter-grammars}/langs\""
        '';
      });
    };
  };

}
