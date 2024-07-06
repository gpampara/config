{ config, pkgs, ... }:

let
  fullname = "Gary Pamparà";
  emailAddr = "gpampara@gmail.com";

  util = pkgs.callPackage ./util.nix { };
in
{
  imports = [
    ./config
  ];

  #caches.cachix = [
  #    { name = "nix-community"; sha256 = "0m6kb0a0m3pr6bbzqz54x37h5ri121sraj1idfmsrr6prknc7q3x"; }
  #];

  sops = {
    age.keyFile = "${config.home.homeDirectory}/.age-key.txt";
    defaultSopsFile = ./secrets/secrets.yaml;
    secrets = {
      work-email-pass = {
        path = "%r/work-email-password.txt";
      };
    };
  };

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
  home.stateVersion = "23.11"; # Please read the comment before changing.

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
    pkgs.sops
    pkgs.age

    pkgs.aspell
    pkgs.aspellDicts.en
    pkgs.aspellDicts.en-computers

    pkgs.bitwarden-cli

    pkgs.dos2unix

    pkgs.gnupg
    pkgs.graphviz

    pkgs.ledger
    pkgs.jq
    pkgs.fx

    # fonts
    pkgs.nerdfonts
    pkgs.dejavu_fonts

    #romcal
    pkgs.watchman

    pkgs.gitAndTools.git-crypt
    pkgs.difftastic
    #pkgs.unstable.git-ps-rs
    pkgs.gh # github cli tool
    pkgs.sapling

    #(util.forSystem { linux = pkgs.mpv; darwin = pkgs.unstable.iina; })
    (util.forSystem { linux = pkgs.mpv; darwin = pkgs.iina; })

    pkgs.ripgrep
    pkgs.shellcheck
    #pkgs.stack

    #(util.forSystem { linux = pkgs.tailscale; darwin = null; })
    pkgs.tigervnc
    pkgs.yt-dlp

    (util.forSystem { linux = pkgs.zotero; darwin = pkgs.dmgPkgs.zotero; }) # Install Zotero
    (util.forSystem { linux = pkgs.zathura; darwin = pkgs.dmgPkgs.skim-pdf; })

    #pkgs.unstable.flix
    pkgs.flix
    pkgs.gleam
  ];

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      connect-timeout = 5
      log-lines = 25

      experimental-features = nix-command flakes
    '';
  };

  #colorScheme = nix-colors.colorSchemes.catppuccin-mocha;
  stylix.enable = true;
  #stylix.image =
  #  util.forSystem {
  #    linux = pkgs.fetchurl {
  #      url = "https://www.pixelstalk.net/wp-content/uploads/2016/05/Epic-Anime-Awesome-Wallpapers.jpg";
  #      sha256 = "enQo3wqhgf0FEPHj2coOCvo7DuZv+x5rL/WIo4qPI50=";
  #    };
  #    darwin = null;
  #  };
  stylix.image = ./fake.png;
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-medium.yaml";
  stylix.polarity = "dark";

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
      #{ id = "gighmmpiobklfepjocnamgkkbiglidom"; } # Ad blocker
      { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # ublock origin
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
      if test -e /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
        fenv source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
      end

      # This was removed in https://github.com/nix-community/home-manager/commit/3e4fedc1d9c53a0fad0a4e5b63880ab13d1e249d
      # but not sure why??
      ${pkgs.direnv}/bin/direnv hook fish | source
    '';

    shellAbbrs = {
      "hm-rm-old-generations" = "home-manager generations | tail -n +2 | awk '{ print $5 }' | xargs home-manager remove-generations";
      "hm-update" = "cd ~/.config/home-manager; bash update.sh; cd -";
    };

    # interactiveShellInit =
    #   let
    #     nix-colors-lib = nix-colors.lib.contrib { inherit pkgs; };
    #   in
    #   ''
    #     ${pkgs.bash}/bin/bash ${nix-colors-lib.shellThemeFromScheme { scheme = config.colorScheme; }}
    #   '';
  };

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
  };

  # programs.ssh = {
  #   enable = true;
  #   addKeysToAgent = "7h";
  # };

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      python.python_binary = [ "${pkgs.python3}/bin/python" ];
    };
  };

  programs.fzf = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.git = {
    enable = true;
    userName = fullname;
    difftastic.enable = true;
    ignores = [
      "node_modules"
      ".DS_Store"
      ".jj"
    ];
    aliases = {
      st = "status";

      # list all aliases
      aliases = "!git config --get-regexp 'alias.*' | colrm 1 6 | sed 's/[ ]/ = /' | sort";

      # WIP status of branches
      wip = "!git for-each-ref --sort='authordate:iso8601' --format=' %(color:green)%(authordate:relative)%09%(color:white)%(refname:short)' refs/heads | tail -r";

      # https://github.com/not-an-aardvark/git-delete-squashed
      gone = ''
        !git checkout -q master && git for-each-ref refs/heads/ "--format=%(refname:short)" | while read branch; do mergeBase=$(git merge-base master $branch) && [[ $(git cherry master $(git commit-tree $(git rev-parse "$branch^{tree}") -p $mergeBase -m _)) == "-"* ]] && git branch -D $branch; done
      '';

      file-log = "log --follow -p -- ";

      recent = ''branch --sort=-committerdate --format="%(committerdate:relative)%09%(refname:short)"'';
    };
    extraConfig = {
      user = {
        useConfigOnly = true;
      };
      github = {
        user = config.home.username;
      };
    };
  };

  programs.jujutsu = {
    enable = true;
    #package = pkgs.unstable.jujutsu;
    settings = {
      core = {
        fsmonitor = "watchman";
      };

      user = {
        name = "${fullname}";
      };

      revset-aliases = {
        MINE = "ancestors(mine() ~ ::trunk(), 2) | trunk() | @";
      };

      # revset-aliases = {
      #   MINE = "author(${config.home.username})";
      #   MY_HEAD = "((visible_heads() & ::MINE & (~empty() | merges())) | @)";
      #   MAIN = ''(present("main") | present("master"))'';
      #   DEFAULT = "MAIN | (::MY_HEAD~::MAIN) | (::MY_HEAD~::MAIN)-";
      # };

      # revsets = {
      #   log = "DEFAULT | root()";
      # };

      snapshot = {
        max-new-file-size = "4MiB";
      };
    };
  };

  # https://github.com/nix-community/home-manager/pull/5207
  home.sessionVariables = pkgs.lib.mkIf (pkgs.stdenv.hostPlatform.isDarwin) {
    JJ_CONFIG = "${config.xdg.configHome}/jj/config.toml";
  };

  # programs.sapling = {
  #   enable = true;
  #   userName = "${fullname}";
  # };

  programs.mcfly = {
    enable = true;
  };

  programs.wezterm = {
    enable = true;
    package = util.forSystem { linux = pkgs.wezterm; darwin = pkgs.hello; };
    extraConfig = ''
      local act = wezterm.action
      local config = {}

      config.check_for_updates = true
      config.show_update_window = true

      config.initial_cols = 175
      config.initial_rows = 52

      config.hide_tab_bar_if_only_one_tab = true

      function DoSplit ()
        local pane_count = wezterm.MuxTab.panes_with_info()
      end

      config.keys = {
        { key = '{', mods = 'CTRL|SHIFT', action = act.ActivatePaneDirection 'Prev' },
        { key = '}', mods = 'CTRL|SHIFT', action = act.ActivatePaneDirection 'Next' },
        -- { key = 'Enter', mods = 'CMD', action = },
      }

      wezterm.on('gui-startup', function(cmd)
        local tab, pane, window = mux.spawn_window(cmd or {})
        window:set_position(15,25)
      end)

      return config
    '';
  };

  programs.zoxide = {
    enable = true;
    options = [ "--cmd cd" ];
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
      circuithub = {
        primary = true;
        flavor = "gmail.com";
        address = "garyp@circuithub.com";
        userName = "garyp@circuithub.com";
        realName = fullname;
        passwordCommand = "cat ${config.sops.secrets.work-email-pass.path}";
        imap.tls = {
          enable = true;
          certificatesFile = "${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt";
        };
        smtp.tls.useStartTls = true;
        mbsync = {
          enable = true;
          create = "both";
          expunge = "both";
          patterns = [
            "*"
            "![Gmail]*"
            "[Gmail]/Sent Mail"
            "[Gmail]/Starred"
            "[Gmail]/All Mail"
            "[Gmail]/Trash"
          ];
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
  # home.sessionVariables = {
  #   # EDITOR = "emacs";
  # };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
