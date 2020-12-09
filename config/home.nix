{ config, lib, pkgs, ... }:

let
  username = "gpampara";
  homeDirectory = "/Users/gpampara";
in
{
  imports = [
    ./dev
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = username;
  home.homeDirectory = homeDirectory;

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "20.09";

  # General packages
  home.packages = with pkgs; [
    #nixUnstable

    aspell
    aspellDicts.en
    aspellDicts.en-computers
    aspellDicts.en-science

    # Elm
    elmPackages.elm
    elmPackages.elm-analyse
    elmPackages.elm-format
    elmPackages.elm-test

    graphviz
    ledger
    jq
    nodejs
    gitAndTools.git-crypt

    pijul

    ripgrep                       # rg, fast grepper
    shellcheck
    # stack
    #tectonic # latex build process (experimental)
    tmux
    vagrant
    yarn
  ];

  programs.fish = {
    enable = true;

    shellInit = ''
      # Disable the fish welcome message
      set fish_greeting

      set -p fish_function_path ${pkgs.fish-foreign-env}/share/fish-foreign-env/functions

      # nix
      if test -e ${homeDirectory}/.nix-profile/etc/profile.d/nix.sh
        fenv source ${homeDirectory}/.nix-profile/etc/profile.d/nix.sh
      end
    '';

    promptInit = builtins.readFile ./fish/fish_prompt.fish;
  };

  programs.git = {
    package = pkgs.gitAndTools.gitFull;
    enable = true;
    userName = "Gary Pamparà";
    aliases = {
      # https://github.com/not-an-aardvark/git-delete-squashed
      gone =''
        ! ${pkgs.bash}/bin/bash -c 'git fetch -a -p && git for-each-ref refs/heads/ "--format=%(refname:short)" | while read branch; do mergeBase=$(git merge-base origin/master $branch) && [[ $(git cherry origin/master $(git commit-tree $(git rev-parse $branch\^{tree}) -p $mergeBase -m _)) == "-"* ]] && git branch -D $branch; done; echo ""'
     '';

      # list all aliases
      aliases = "!git config --get-regexp 'alias.*' | colrm 1 6 | sed 's/[ ]/ = /' | sort";
    };
    extraConfig = {
      user = {
        useConfigOnly = true;
      };
      github = {
        user = username;
      };
    };
  };

  # Enabling direnv will automatically add `eval (direnv hook fish)` to programs.fish.shellInit
  programs.direnv = {
    enable = true;
    enableNixDirenvIntegration = true;
  };
}
