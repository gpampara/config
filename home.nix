{ config, lib, pkgs, ... }:

let
  username = "gpampara";
  fullname = "Gary Pamparà";
  emailAddr = "gpampara@gmail.com";
  homeDirectory = "/Users/${username}";

  secrets = import ./secrets/secrets.nix;

  util = pkgs.callPackage ./util.nix {};
in
{
  imports = [
    ./config/dev
  ];

  caches.cachix = [
    { name = "nix-community"; sha256 = "00lpx4znr4dd0cc4w4q8fl97bdp7q19z1d3p50hcfxy26jz5g21g"; }
  ];

  home.username = username;
  home.homeDirectory = homeDirectory;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # General global packages for the user
  home.packages = with pkgs; [
    aspell
    aspellDicts.en
    aspellDicts.en-computers
    aspellDicts.en-science

    bitwarden-cli

    (util.forSystem { linux = element-desktop; darwin = dmgPkgs.element; })
    #(forSystem { linux = slack; darwin = dmgPkgs.slack; })

    gnupg
    graphviz
    ledger
    jq

    # fonts
    nerdfonts
    jetbrains-mono
    inter

    nodejs
    nodePackages.node2nix
    #romcal
    gitAndTools.git-crypt
    fzf

    pijul

    (util.forSystem { linux = mpv; darwin = dmgPkgs.iina; })
    (util.forSystem { linux = dbeaver; darwin = dmgPkgs.postico; })

    ripgrep
    shellcheck
    stack

    vagrant

    tailscale

    yarn
    yt-dlp

    (util.forSystem { linux = zotero; darwin = dmgPkgs.zotero; }) # Install Zotero
    (util.forSystem { linux = zathura; darwin = dmgPkgs.skim-pdf; })
  ]; #++ lib.optional pkgs.stdenv.isDarwin [];

  home.file.nixConf.text = ''
    experimental-features = nix-command flakes
  '';

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
      if test -e ${homeDirectory}/.nix-profile/etc/profile.d/nix.sh
        fenv source ${homeDirectory}/.nix-profile/etc/profile.d/nix.sh
      end

      # This was removed in https://github.com/nix-community/home-manager/commit/3e4fedc1d9c53a0fad0a4e5b63880ab13d1e249d
      # but not sure why??
      ${pkgs.direnv}/bin/direnv hook fish | source
    '';

    shellAbbrs = {
      "hm-rm-old-generations" = "home-manager generations | tail -n +2 | awk '{ print $5 }' | xargs home-manager remove-generations";
    };
  };

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
    aliases = {
      # https://github.com/not-an-aardvark/git-delete-squashed
      gone = ''
        ! ${pkgs.bash}/bin/bash -c 'git fetch -a -p && git for-each-ref refs/heads/ "--format=%(refname:short)" | grep -v master | grep -v main | while read branch; do mergeBase=$(git merge-base origin/master $branch) && [[ $(git cherry origin/master $(git commit-tree $(git rev-parse $branch\^{tree}) -p $mergeBase -m _)) == "-"* ]] && git branch -D $branch; done; echo ""'
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
      merge = {
        conflictstyle = "diff3";
      };
    };
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
      '';

      linuxOptions = ''
      '';
    in
    {
      enable = true;
      extraConfig =
        lib.strings.concatStringsSep "\n"
          [ "font_size 12.0"
            "cursor_blink_interval 0"
            draculaDiffConf
            draculaConf
            (lib.strings.optionalString pkgs.stdenv.isDarwin macosOptions)
            (lib.strings.optionalString pkgs.stdenv.isLinux linuxOptions)
          ];
    };

  # Custom config files
  home.file.".aspell.conf".text = ''
    data-dir ${homeDirectory}/.nix-profile/lib/aspell
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

}
