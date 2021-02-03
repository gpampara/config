{ pkgs, stdenv ? pkgs.stdenv, ... }:

let
  modernSexyIconV1 = pkgs.fetchurl {
    url = https://github.com/d12frosted/homebrew-emacs-plus/raw/master/icons/modern-sexy-v1.icns;
    sha256 = "086qz0k8lvvwlq3kr0lm5qj7m94s7gjhk00jpr3m08kg3xfm3a0y";
  };

  emacsPlus = pkgs.emacs.overrideAttrs(attrs: {
    buildInputs =
      attrs.buildInputs ++ pkgs.lib.optionals stdenv.isLinux [
        pkgs.libvterm
      ];

    patches = attrs.patches ++ [
      ./emacs-27-system-appearance.patch
      ./emacs-27-fix-window-role.patch
    ];

    # This changes the default Emacs icon to on that is more pleasing :)
    # Icons taken from the emacs-plus homebrew formula
    preBuild = ''
      cp ${modernSexyIconV1} ./nextstep/Cocoa/Emacs.base/Contents/Resources/Emacs.icns
    '';
  });
in
emacsPlus
