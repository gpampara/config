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
      package = util.forSystem {
        darwin = nixpkgsUnstable.pkgs.emacs29-macport;
        linux = pkgs.emacsGit;
      };
    };
}
