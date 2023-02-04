{ pkgs, ... }: 
let
  util = pkgs.callPackage ../../util.nix { };
in{

  imports = [
    ./emacs
  ];

  programs.emacs =
    {
      enable = true;
      package = util.forSystem {
        darwin = pkgs.emacsMacport;
        linux = pkgs.emacsGit;
      };    
    };
}
