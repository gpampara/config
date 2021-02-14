{ config, lib, pkgs, ... }:

let
  username = "gpampara";
  fullname = "Gary Pamparà";
  emailAddr = "gpampara@gmail.com";
  homeDirectory = "/Users/gpampara";

  forSystem = { linux, darwin }:
    if pkgs.stdenv.isDarwin then darwin else linux;
in
{
  imports = [
    ./config/dev
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

  # General global packages for the user
  home.packages = with pkgs; [
    nixUnstable

    aspell
    aspellDicts.en
    aspellDicts.en-computers
    aspellDicts.en-science

    (forSystem { linux = element-desktop; darwin = dmgPkgs.element; })

    graphviz
    ledger
    jq
    nodejs
    gitAndTools.git-crypt

    #pijul

    ripgrep
    shellcheck
    # stack
    tectonic # latex build process (experimental) - Why can't this use the system latex?
    tmux
    vagrant
    yarn
    youtube-dl

    (forSystem { linux = zotero; darwin = dmgPkgs.zotero; })     # Install Zotero
    #(forSystem { linux = zathura; darwin = dmgPkgs.skim; })
  ]; #++ lib.optional pkgs.stdenv.isDarwin [];

  programs.brave = {
    enable = true;
    package = forSystem {
      darwin = pkgs.dmgPkgs.brave;
      linux = pkgs.brave;
    };
    extensions = [
      { id = "hdokiejnpimakedhajhdlcegeplioahd"; }
      { id = "ekhagklcjbdpajgpjgmbionohlpdbjgc"; } # Zotero
    ];
  };

  # Enabling direnv will automatically add `eval (direnv hook fish)` to programs.fish.shellInit
  programs.direnv = {
    enable = true;
    enableNixDirenvIntegration = true;
  };

  programs.fish = {
    enable = true;

    shellInit = ''
      # Disable the fish welcome message
      set fish_greeting

      set -p fish_function_path ${pkgs.fishPlugins.foreign-env}/share/fish/vendor_functions.d

      # nix
      if test -e ${homeDirectory}/.nix-profile/etc/profile.d/nix.sh
        fenv source ${homeDirectory}/.nix-profile/etc/profile.d/nix.sh
      end
    '';

    shellAbbrs = {
      "hm-rm-old-generations" = "home-manager generations | tail -n +2 | awk '{ print $5 }' | xargs home-manager remove-generations";
    };

    promptInit = builtins.readFile ./config/fish/fish_prompt.fish;
  };

  programs.git = {
    package = pkgs.gitAndTools.gitFull;
    enable = true;
    userName = fullname;
    aliases = {
      # https://github.com/not-an-aardvark/git-delete-squashed
      gone =''
        ! ${pkgs.bash}/bin/bash -c 'git fetch -a -p && git for-each-ref refs/heads/ "--format=%(refname:short)" | while read branch; do mergeBase=$(git merge-base origin/master $branch) && [[ $(git cherry origin/master $(git commit-tree $(git rev-parse $branch\^{tree}) -p $mergeBase -m _)) == "-"* ]] && git branch -D $branch; done; echo ""'
     '';

      # list all aliases
      aliases = "!git config --get-regexp 'alias.*' | colrm 1 6 | sed 's/[ ]/ = /' | sort";

      # WIP status of branches
      wip = "!git for-each-ref --sort='authordate:iso8601' --format=' %(color:green)%(authordate:relative)%09%(color:white)%(refname:short)' refs/heads | tail -r";
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
}
