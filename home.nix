{ config, pkgs, ... }:

let
  fullname = "Gary Pamparà";
  emailAddr = "gpampara@gmail.com";

  secrets = import ./secrets/secrets.nix;
  util = pkgs.callPackage ./util.nix {};
in
{
  caches.cachix = [
    { name = "nix-community"; sha256 = "0m6kb0a0m3pr6bbzqz54x37h5ri121sraj1idfmsrr6prknc7q3x"; }
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  #home.username = username;
  #home.homeDirectory = homeDirectory;

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
    pkgs.aspell
    pkgs.aspellDicts.en
    pkgs.aspellDicts.en-computers
    pkgs.aspellDicts.en-science

    pkgs.bitwarden-cli

    pkgs.dos2unix

    #(util.forSystem { linux = element-desktop; darwin = dmgPkgs.element; })

    pkgs.gnupg
    pkgs.graphviz
    pkgs.helix

    pkgs.ledger
    pkgs.jq

    # fonts
    pkgs.nerdfonts
    pkgs.jetbrains-mono
    pkgs.inter

    pkgs.nodejs
    pkgs.nodePackages.node2nix
    #romcal

    pkgs.delta
    pkgs.gitAndTools.git-crypt
    pkgs.difftastic
    pkgs.git-ps-rs
    pkgs.gh # github cli tool

    pkgs.fzf

    #pijul
    #jujutsu
    #nixpkgs-unstable.sapling

    (util.forSystem { linux = pkgs.mpv; darwin = pkgs.dmgPkgs.iina; })

    pkgs.ripgrep
    pkgs.shellcheck
    pkgs.stack

    pkgs.tailscale

    pkgs.yarn
    pkgs.yt-dlp

    (util.forSystem { linux = pkgs.zotero; darwin = pkgs.dmgPkgs.zotero; }) # Install Zotero
    (util.forSystem { linux = pkgs.zathura; darwin = pkgs.dmgPkgs.skim-pdf; })
  ];

  nix = {
    package = pkgs.nix;
    extraOptions = ''
      connect-timeout = 5
      log-lines = 25

      experimental-features = nix-command flakes
    '';
  };

  programs.brave = {
    enable = true;
    package = util.forSystem {
      darwin = pkgs.dmgPkgs.brave;
      linux = pkgs.brave;
    };
    extensions = [
      { id = "nngceckbapebfimnlniiiahkandclblb"; } # Bitwarden
      { id = "ekhagklcjbdpajgpjgmbionohlpdbjgc"; } # Zotero
      { id = "edlhclhffmclbhgifomamlomnfolnepa"; } # Elm debug helper
      { id = "fjdmkanbdloodhegphphhklnjfngoffa"; }
      { id = "gighmmpiobklfepjocnamgkkbiglidom"; } # Ad blocker
    ];
  };

  # Enabling direnv will automatically add `eval (direnv hook fish)` to programs.fish.shellInit
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.fish = {
    enable = true;

    shellInit = ''
      # Disable the fish welcome message
      set fish_greeting

      set -p fish_function_path ${pkgs.fishPlugins.foreign-env}/share/fish/vendor_functions.d

      # nix
      if test -e ${config.home.homeDirectory}/.nix-profile/etc/profile.d/nix.sh
        fenv source ${config.home.homeDirectory}/.nix-profile/etc/profile.d/nix.sh
      end

      # This was removed in https://github.com/nix-community/home-manager/commit/3e4fedc1d9c53a0fad0a4e5b63880ab13d1e249d
      # but not sure why??
      ${pkgs.direnv}/bin/direnv hook fish | source
    '';

    shellAbbrs = {
      "hm-rm-old-generations" = "home-manager generations | tail -n +2 | awk '{ print $5 }' | xargs home-manager remove-generations";
    };
  };

  xdg.configFile."fish/functions/goto.fish".text =
    let
      goto_src =
        pkgs.fetchurl {
          url = https://raw.githubusercontent.com/matusf/goto/master/functions/goto.fish;
          sha256 = "sha256-nfXLRsi+f42e1r7nMkf7aiQmBGH7Qz4KjQdE/fDZ4V4=";
        };
    in
    (builtins.readFile goto_src);

  xdg.configFile."fish/conf.d/dracula.fish".text = ''
    # Dracula Color Palette
    set -l foreground f8f8f2
    set -l selection 44475a
    set -l comment 6272a4
    set -l red ff5555
    set -l orange ffb86c
    set -l yellow f1fa8c
    set -l green 50fa7b
    set -l purple bd93f9
    set -l cyan 8be9fd
    set -l pink ff79c6

    # Syntax Highlighting Colors
    set -g fish_color_normal $foreground
    set -g fish_color_command $cyan
    set -g fish_color_keyword $pink
    set -g fish_color_quote $yellow
    set -g fish_color_redirection $foreground
    set -g fish_color_end $orange
    set -g fish_color_error $red
    set -g fish_color_param $purple
    set -g fish_color_comment $comment
    set -g fish_color_selection --background=$selection
    set -g fish_color_search_match --background=$selection
    set -g fish_color_operator $green
    set -g fish_color_escape $pink
    set -g fish_color_autosuggestion $comment

    # Completion Pager Colors
    set -g fish_pager_color_progress $comment
    set -g fish_pager_color_prefix $cyan
    set -g fish_pager_color_completion $foreground
    set -g fish_pager_color_description $comment
  '';

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.git = {
    enable = true;
    userName = fullname;
    ignores = [
      "node_modules"
      ".DS_Store"
    ];
    aliases = {
      # list all aliases
      aliases = "!git config --get-regexp 'alias.*' | colrm 1 6 | sed 's/[ ]/ = /' | sort";

      # WIP status of branches
      wip = "!git for-each-ref --sort='authordate:iso8601' --format=' %(color:green)%(authordate:relative)%09%(color:white)%(refname:short)' refs/heads | tail -r";

      # https://github.com/not-an-aardvark/git-delete-squashed
      gone = ''
        !git checkout -q master && git for-each-ref refs/heads/ "--format=%(refname:short)" | while read branch; do mergeBase=$(git merge-base master $branch) && [[ $(git cherry master $(git commit-tree $(git rev-parse "$branch^{tree}") -p $mergeBase -m _)) == "-"* ]] && git branch -D $branch; done
      '';
    };
    extraConfig = {
      user = {
        useConfigOnly = true;
      };
      github = {
        user = config.home.username;
      };
      merge = {
        conflictstyle = "diff3";
      };
    };
  };

  programs.jujutsu = {
    enable = true;
    package = pkgs.jujutsu;
  };

  programs.kitty =
    let
      draculaGH = pkgs.fetchFromGitHub {
        owner = "dracula";
        repo = "kitty";
        rev = "6d6239abe975e168e6ffb8b19c03a997bbe88fe6";
        sha256 = "EUS6/CPhx+OfoiW1sOrhJ8NFiNnmcfryBl8STt+nzLs=";
      };
      draculaConf = builtins.readFile (draculaGH + "/dracula.conf");
      draculaDiffConf = builtins.readFile (draculaGH + "/diff.conf");

      macosOptions = ''
        map cmd+c        copy_to_clipboard
        map cmd+v        paste_from_clipboard
        map shift+insert paste_from_clipboard

        mouse_map ctrl+left press ungrabbed,grabbed mouse_click_url

        copy_on_select yes

        macos_option_as_alt yes
        macos_quit_when_last_window_closed no
      '';

      linuxOptions = ''
      '';
    in
    {
      enable = true;
      package = util.forSystem
        {
          linux = pkgs.kitty;
          darwin = pkgs.hello;
        };
      extraConfig =
        pkgs.lib.strings.concatStringsSep "\n"
          [
            "font_size 12.0"
            "cursor_blink_interval 0"
            "cursor_shape block"
            "shell_integration enabled,no-cursor"
            draculaDiffConf
            draculaConf
            (pkgs.lib.strings.optionalString pkgs.stdenv.isDarwin macosOptions)
            (pkgs.lib.strings.optionalString pkgs.stdenv.isLinux linuxOptions)
          ];
    };

  # Custom config files
  home.file.".aspell.conf".text = ''
    data-dir ${config.home.homeDirectory}/.nix-profile/lib/aspell
  '';

    # Accounts for email
  programs.mu.enable = true;
  programs.mbsync.enable = true;

  accounts.email = {
    accounts = {
      "${secrets.email.work.address}" = {
        primary = true;
        flavor = secrets.email.work.flavor;
        address = secrets.email.work.address;
        userName = secrets.email.work.address;
        realName = fullname;
        passwordCommand = "echo ${secrets.email.work.password}";
        imap.tls = {
          enable = true;
          certificatesFile = "${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt";
        };
        smtp.tls.useStartTls = true;
        mbsync = {
          enable = true;
          create = "both";
          expunge = "both";
          patterns = secrets.email.work.patterns;
        };
      };
    };
  };


  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/gpampara/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
