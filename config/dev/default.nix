{ pkgs, ... }: {

  imports = [
    ./emacs
  ];

  programs.emacs = {
    enable = true;
    package = pkgs.emacsPgtk;
  };

}
