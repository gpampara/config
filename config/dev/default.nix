{ pkgs, ... }: {

  imports = [
    ./emacs
  ];

  programs.emacs = {
    enable = true;
    package = import ./emacsPlus { inherit pkgs; };
  };

}
