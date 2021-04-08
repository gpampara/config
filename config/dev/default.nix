{ pkgs, ... }: {

  imports = [
    ./emacs
  ];

  programs.emacs = {
    enable = true;
    package = pkgs.emacsPgtkGcc;
  };

}
