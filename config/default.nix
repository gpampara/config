{ pkgs, nixpkgsUnstable, ... }:
let
  util = pkgs.callPackage ../util.nix { };
in{

  imports = [
    ./emacs
  ];

  programs.emacs =
    {
      enable = true;
      extraPackages = epkgs: [ epkgs.treesit-grammars.with-all-grammars ];
      package = util.forSystem {
        darwin = pkgs.emacs29-macport;
        linux = pkgs.emacsGit;
      };
    };
}
