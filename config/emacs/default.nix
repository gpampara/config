{ pkgs, lib, config, ... }: {

  # Use the home-manager module for emacs provided in the flake.nix
  # configuration: nur-no-pkgs.repos.rycee.hmModules.emacs-init

  programs.emacs.init = {
    enable = true;
    recommendedGcSettings = true;

    earlyInit = ''
      ;; Disable some GUI distractions. We set these manually to avoid starting
      ;; the corresponding minor modes.
      (push '(menu-bar-lines . 0) default-frame-alist)
      (push '(tool-bar-lines . nil) default-frame-alist)
      (push '(vertical-scroll-bars . nil) default-frame-alist)
      (blink-cursor-mode 0)
    '';

    prelude = builtins.readFile ./prelude.el;

    # TODO: The loading of mu4e could be done in a better way?
    postlude =
      let
        # mu4eConfig = builtins.readFile ./mu4e-config.el;
        postludeFile = builtins.readFile ./postlude.el;
      in
      builtins.concatStringsSep "\n"
        [
          # ''(defconst mu4e-load-path "${pkgs.mu}/share/emacs/site-lisp/mu4e" "Location of mu4e elisp")''
          # mu4eConfig
          postludeFile
        ];


    usePackage = {

      ace-window = {
        enable = true;
        command = [ "ace-window" ];
        bind = {
          "M-o" = "ace-window";
        };
        config = ''
          (setq aw-dispatch-alist
                '((?x aw-delete-window " Ace - Delete Window")
                (?m aw-swap-window " Ace - Swap Window")
                (?n aw-flip-window)
                (?v aw-split-window-vert " Ace - Split Vert Window")
                (?h aw-split-window-horz " Ace - Split Horz Window")
                (?i delete-other-windows " Ace - Maximize Window")
                (?o delete-other-windows)
                (?b balance-windows)))

          (add-to-list 'aw-dispatch-alist '(?w hydra-window-size/body) t)
          (add-to-list 'aw-dispatch-alist '(?\; hydra-window-frame/body) t)

          (ace-window-display-mode t)
        '';
      };

      astro-ts-mode = {
        enable = false;
        extraPackages = [
          pkgs.nodePackages.astro-language-server
          pkgs.nodePackages.typescript
        ];
        config = ''
          (with-eval-after-load 'eglot
            (add-to-list 'eglot-server-programs
              `(astro-ts-mode . ("${pkgs.nodePackages.astro-language-server}/bin/astro-ls" "--stdio" :initializationOptions (:typescript (:tsdk "${pkgs.nodePackages.typescript}/lib/node_modules/typescript/lib"))))))
        '';
      };

      async = {
        enable = true;
      };

      auto-dark = {
        enable = true;
        after = [ "catppuccin-theme" ];
        config = ''
          (setq auto-dark-dark-theme 'catppuccin)
          (setq auto-dark-light-theme 'catppuccin)

          (add-hook 'auto-dark-dark-mode-hook
            (lambda ()
              (setq catppuccin-flavor 'mocha)
              (catppuccin-reload)))

          (add-hook 'auto-dark-light-mode-hook
            (lambda ()
              (setq catppuccin-flavor 'latte)
              (catppuccin-reload)))

          (if (eq system-type 'darwin)
              (setq auto-dark-allow-osascript t))

          (auto-dark-mode 1)
        '';
      };

      latex = {
        enable = true;
        package = epkgs: epkgs.auctex;
        mode = [ ''("\\.tex\\'" . latex-mode)'' ];
        bindLocal = {
          LaTeX-mode-map = {
            "M-q" = "ales/fill-paragraph";
          };
        };
        hook = [
          "(latex-mode . lsp-deferred)"
          #"(latex-mode . eglot-ensure)"
        ];
        extraPackages =
          [
            pkgs.lua53Packages.digestif # https://github.com/astoff/digestif
          ];
        config = builtins.readFile ./auctex-config.el;
      };

      avy = {
        enable = true;
        command = [ "avy-goto-char-timer" ];
        bind = {
          "C-:" = "avy-goto-char-timer";
        };
      };

      catppuccin-theme = {
        enable = true;
        config = ''
          (load-theme 'catppuccin :no-confirm)

          (setq catppuccin-flavor 'latte) ;; or 'latte, 'macchiato, or 'mocha
          (catppuccin-reload)
        '';
      };

      coffee-mode = {
        enable = true;
        mode = [ ''"\\.coffee\\'"'' ];
      };

      consult = {
        enable = true;
        bind = {
          "C-c M-x" = "consult-mode-command";
          "C-c h" = "consult-history";
          "C-c k" = "consult-kmacro";
          "C-c m" = "consult-man";
          "C-c i" = "consult-info";
          # C-x bindings in `ctl-x-map'
          "C-x M-:" = "consult-complex-command"; # orig. repeat-complex-command
          "C-x b" = "consult-buffer"; # orig. switch-to-buffer
          "C-x 4 b" = "consult-buffer-other-window"; # orig. switch-to-buffer-other-window
          "C-x 5 b" = "consult-buffer-other-frame"; # orig. switch-to-buffer-other-frame
          "C-x t b" = "consult-buffer-other-tab"; # orig. switch-to-buffer-other-tab
          "C-x r b" = "consult-bookmark"; # orig. bookmark-jump
          "C-x p b" = "consult-project-buffer"; # orig. project-switch-to-buffer
          # Custom M-# bindings for fast register access
          "M-#" = "consult-register-load";
          "M-'" = "consult-register-store"; # orig. abbrev-prefix-mark (unrelated)
          "C-M-#" = "consult-register";
          # Other custom bindings
          "M-y" = "consult-yank-pop"; # orig. yank-pop
          # M-g bindings in `goto-map'
          "M-g e" = "consult-compile-error";
          "M-g f" = "consult-flymake"; # Alternative: consult-flycheck
          "M-g g" = "consult-goto-line"; # orig. goto-line
          "M-g M-g" = "consult-goto-line"; # orig. goto-line
          "M-g o" = "consult-outline"; # Alternative: consult-org-heading
          "M-g m" = "consult-mark";
          "M-g k" = "consult-global-mark";
          "M-g i" = "consult-imenu";
          "M-g I" = "consult-imenu-multi";
          #  M-s bindings (search-map)
          "M-s f" = "consult-find";
          "M-s L" = "consult-locate";
          "M-s g" = "consult-grep";
          "M-s G" = "consult-git-grep";
          "M-s r" = "consult-ripgrep";
          "M-s l" = "consult-line";
          "M-s m" = "consult-multi-occur";
          "M-s k" = "consult-keep-lines";
          "M-s u" = "consult-focus-lines";
          # Isearch integration
          "M-s e" = "consult-isearch-history";
        };
        bindLocal = {
          isearch-mode-map = {
            "M-e" = "consult-isearch-history"; # orig. isearch-edit-string
            "M-s e" = "consult-isearch-history"; # orig. isearch-edit-string
            "M-s l" = "consult-line"; # needed by consult-line to detect isearch
            "M-s L" = "consult-line-multi"; # needed by consult-line to detect isearch
          };

          # Minibuffer history
          minibuffer-local-map = {
            "M-s" = "consult-history"; # orig. next-matching-history-element
            "M-r" = "consult-history"; # orig. previous-matching-history-element
          };
        };
        config = ''
          ;; Optionally configure preview. The default value
          ;; is 'any, such that any key triggers the preview.
          ;; (setq consult-preview-key 'any)
          ;; (setq consult-preview-key (kbd "M-."))
          ;; (setq consult-preview-key (list (kbd "<S-down>") (kbd "<S-up>")))
          ;; For some commands and buffer sources it is useful to configure the
          ;; :preview-key on a per-command basis using the `consult-customize' macro.
          (consult-customize
            consult-ripgrep consult-git-grep consult-grep
            consult-bookmark consult-recent-file consult-xref
            consult--source-bookmark consult--source-recent-file
            consult--source-project-recent-file
            :preview-key "M-.")

          ;; Specify that searches with consult should start from the root of the project (if exists)
          (setq consult-project-root-function
                  (lambda ()
                    (when-let (project (project-current))
                      (car (project-roots project)))))

          ;; Use smart-casing for ripgrep (i.e. case-insensitive search until uppercase character is provided)
          (setq consult-ripgrep-command "rg -S --null --line-buffered --color=ansi --max-columns=1000 --no-heading --line-number . -e ARG OPTS")
        '';
        extraConfig = ''
          :bind
          (([remap goto-line] . consult-goto-line)
           ([remap Info-search] . consult-info)
          )
        '';
        extraPackages = [ pkgs.ripgrep ];
      };

      # consult-eglot = {
      #   enable = true;
      # };

      # Instead of moving to column 0, move the the beginning of the
      # text on the line.
      crux = {
        enable = true;
        bind = {
          "C-a" = "crux-move-beginning-of-line";
          "C-c t" = "crux-visit-term-buffer";
        };
      };

      dash = { enable = true; };

      dashboard = {
        enable = true;
        config = builtins.readFile ./dashboard-config.el;
      };

      # dap-mode = {
      #   enable = true;
      #   after = [ "lsp-mode" ];
      #   command = [ "dap-mode" "dap-auto-configure-mode" ];
      #   config = ''
      #     (dap-auto-configure-mode)
      #   '';
      # };

      # dap-mouse = {
      #   enable = true;
      #   command = [ "dap-tooltip-mode" ];
      # };

      # dap-ui = {
      #   enable = true;
      #   after = [ "dap-mode" ];
      #   command = [ "dap-ui-mode" ];
      #   config = ''
      #     (dap-ui-mode t)
      #   '';
      # };

      devdocs = {
        enable = true;
        bind = {
          "C-x C-d" = "devdocs-search";
        };
      };

      direnv = {
        enable = true;
        after = [ "warnings" ];
        config = ''
          (add-to-list 'warning-suppress-types '(direnv))
          (direnv-mode 1)
        '';
      };

      doom-modeline = {
        enable = true;
        config = ''
          (doom-modeline-mode 1)
          (setq doom-modeline-buffer-file-name-style 'relative-from-project)
          (setq doom-modeline-height 15)
        '';
      };

      # doom-themes = {
      #   enable = true;
      #   config = ''
      #     (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
      #           doom-themes-enable-italic t  ; if nil, italics is universally disabled

      #           ;;doom-one specific settings
      #           ;;doom-one-brighter-modeline nil
      #           doom-one-brighter-comments t
      #      )

      #     ;;(load-theme 'doom-gruvbox t)
      #     (load-theme 'doom-one t)

      #     ;; Corrects (and improves) org-mode's native fontification.
      #     (doom-themes-org-config)
      #   '';
      # };

      ef-themes = {
        enable = false;
        config = ''
          ;; Disable all other themes to avoid awkward blending:
          (mapc #'disable-theme custom-enabled-themes)

          (load-theme 'ef-spring :no-confirm)
        '';
      };

      # eglot = {
      #   enable = true;
      #   extraPackages = [
      #     pkgs.jdt-language-server # Java language server
      #     pkgs.nodePackages.bash-language-server
      #     pkgs.nodePackages.typescript-language-server
      #   ];
      #   config = ''
      #     (add-hook 'java-mode 'eglot-ensure)
      #     ;;(add-hook 'java-ts-mode 'eglot-ensure)
      #     (add-hook 'sh-mode 'eglot-ensure)
      #     (add-hook 'js-mode 'eglot-ensure)
      #     ;;(add-hook 'js-ts-mode 'eglot-ensure)

      #     ;; Undo the Eglot modification of completion-category-defaults
      #     (with-eval-after-load 'eglot
      #       (setq completion-category-defaults nil))
      #   '';
      # };

      elm-mode = {
        enable = true;
        mode = [ ''"\\.elm\\'"'' ];
        command = [ "elm-mode" ];
        hook = [
          "(elm-mode . elm-format-on-save-mode)"
        #  "(elm-mode . eglot-ensure)"
        ];
        extraPackages = with pkgs; [
          elmPackages.elm
          elmPackages.elm-format
          elmPackages.elm-test
          elmPackages.elm-review
          elmPackages.elm-language-server
        ];
      };

      emacsql = {
        enable = true;
      };

      emacsql-sqlite = {
        enable = true;
      };

      embark = {
        enable = true;
        bind = {
          "C-." = "embark-act";
        };
      };

      embark-consult = {
        enable = true;
        after = [ "embark" "consult" ];
      };

      ess = {
        enable = true;
      };

      exec-path-from-shell = {
        enable = true;
        config = ''
          (setq exec-path-from-shell-variables '("PATH" "SHELL"))
          (setq exec-path-from-shell-arguments '("-l"))
          (exec-path-from-shell-initialize)
          (setenv "LANG" "en_US")
          (setenv "LC_CTYPE" "en_US.UTF-8")
        '';
      };

      expand-region = {
        enable = true;
        bind = {
          "C-=" = "er/expand-region";
          "C-+" = "er/contract-region";
        };
      };

      f = { enable = true; };

      # Highlight TODO/FIXME within buffers (replace with tree-sitter?)
      fic-mode = {
        enable = true;
        hook = [ "(prog-mode)" ];
      };

      flymake-aspell = {
        enable = true;
        defer = true;
      };

      haskell-mode = {
        enable = true;
        mode = [ ''"\\.hs\\'"'' ];
        config = ''
          (require 'haskell)
        '';
      };

      helpful = {
        enable = true;
        extraConfig = ''
          :bind
          ([remap describe-function] . helpful-callable)
          ([remap describe-command] . helpful-command)
          ([remap describe-variable] . helpful-variable)
          ([remap describe-key] . helpful-key)
        '';
      };

      hippie-expand = {
        enable = true;
        bind = {
          "M-/" = "hippie-expand";
        };
        config = ''
          (setq hippie-expand-try-functions-list
            '(try-expand-dabbrev
              try-expand-dabbrev-all-buffers
              try-expand-dabbrev-from-kill
              try-complete-file-name-partially
              try-complete-file-name
              try-expand-all-abbrevs
              try-expand-list
              try-expand-line
              try-complete-lisp-symbol-partially
              try-complete-lisp-symbol))
        '';
      };

      hl-todo = {
        enable = true;
      };

      hungry-delete = {
        enable = true;
        config = "(global-hungry-delete-mode)";
      };

      # Would be great to define these in the different use-package definitions
      hydra = {
        enable = true;
        config = ''
          (defhydra hydra-window-size (:color red)
            "Window size"
            ("h" shrink-window-horizontally "shrink horizontal")
            ("j" shrink-window "shrink vertical")
            ("k" enlarge-window "enlarge vertical")
            ("l" enlarge-window-horizontally "enlarge horizontal"))

          (defhydra hydra-window-frame (:color red)
            "Frame"
            ("f" make-frame "new frame")
            ("x" delete-frame "delete frame"))

          (defhydra hydra-olivetti-width (:color red)
            "Olivetti panel size"
            ("j" olivetti-shrink "shrink panel width")
            ("k" olivetti-expand "increase panel width")
            ("=" olivetti-set-width "specify panel width"))
        '';
      };

      ibuffer = {
        enable = true;
        bind = {
          "C-x C-b" = "ibuffer";
        };
        config = builtins.readFile ./ibuffer-config.el;
      };

      ledger-mode = {
        enable = true;
        mode = [ ''"\\.ledger\\'"'' ];
        config = ''
          (setq ledger-clear-whole-transactions 1)
          (setq ledger-reconcile-default-commodity "R")
        '';
      };

      markdown-mode = {
        enable = true;
        defer = true;
        hook = [
          "(markdown-mode . flymake-aspell-setup)"
          "(markdown-mode . lsp-deferred)"
        ];
        extraPackages = [
          pkgs.marksman # markdown lsp
        ];
        # config = ''
        #   (add-to-list 'eglot-server-programs '(markdown-mode . ("marksman")))
        #   (add-hook 'markdown-mode-hook #'eglot-ensure)
        # '';
      };

      # lsp-diagnostics = {
      #   enable = true;
      # };

      # lsp-metals = {
      #   enable = true;
      #   defer = true;
      #   after = [ "lsp-mode" ];
      # };

      lsp-mode = {
        enable = true;
        defer = true;
        #after = [ "flycheck" ];
        hook = [
          "(sh-mode . lsp-deferred)"
          "(elm-mode . lsp-deferred)"
          "(java-mode . lsp-deferred)"
          "(js-mode . lsp-deferred)"
          "(scala-mode . lsp-deferred)"
          "(nix-mode . lsp-deferred)"
          "(lsp-mode . lsp-enable-which-key-integration)"
          "(lsp-completion-mode . my/lsp-mode-setup-completion)"
        ];
        extraPackages = [
          pkgs.nodePackages.bash-language-server
          pkgs.nodePackages.typescript-language-server
          pkgs.typescript
        ];
        init = ''
        (defun my/orderless-dispatch-flex-first (_pattern index _total)
          (and (eq index 0) 'orderless-flex))

        (defun my/lsp-mode-setup-completion ()
          (setf (alist-get 'styles (alist-get 'lsp-capf completion-category-defaults))
            '(orderless))
          ;; Optionally configure the first word as flex filtered.
          (add-hook 'orderless-style-dispatchers #'my/orderless-dispatch-flex-first nil 'local)
          ;; Optionally configure the cape-capf-buster.
          (setq-local completion-at-point-functions (list (cape-capf-buster #'lsp-completion-at-point))))
        '';
        config = ''
          (setq lsp-completion-provider :none) ;; we use Corfu!
          ;; (setq lsp-diagnostics-provider :flycheck)
          (setq lsp-enable-xref t)
          (setq lsp-headerline-breadcrumb-enable nil)
          (setq lsp-eldoc-render-all t)

          ;; Performance adjustments (https://emacs-lsp.github.io/lsp-mode/page/performance/)
          (setq read-process-output-max (* 1024 1024)) ;; 1mb

          (push "[/\\\\]vendor$" lsp-file-watch-ignored)
          (push "[/\\\\]node_modules$" lsp-file-watch-ignored)
          (push "[/\\\\]\\.yarn$" lsp-file-watch-ignored)
          (push "[/\\\\]\\.direnv$" lsp-file-watch-ignored)

          (setq lsp-clients-typescript-tls-path "${pkgs.nodePackages.typescript-language-server}/bin/typescript-language-server")
        '';
      };

      lsp-modeline = {
        enable = true;
        after = [ "lsp-mode" ];
      };

      lsp-ui = {
        enable = true;
        command = [ "lsp-ui-mode" ];
        config = ''
          ;;(setq lsp-ui-peek-always-show t)
          ;;(setq lsp-ui-sideline-show-hover t)
          (setq lsp-ui-doc-enable nil)
          (setq lsp-ui-sideline-enable nil)

          (define-key lsp-ui-mode-map [remap xref-find-definitions] #'lsp-ui-peek-find-definitions)
          (define-key lsp-ui-mode-map [remap xref-find-references] #'lsp-ui-peek-find-references)
        '';
      };

      # lsp-ui-flycheck = {
      #   enable = true;
      #   command = [ "lsp-flycheck-enable" ];
      #   after = [ "flycheck" "lsp-ui" ];
      # };

      magit = {
        enable = true;
        bind = {
          "C-x g" = "magit-status";
        };
        config = ''
          ;; https://github.com/magit/magit/issues/2982#issuecomment-598493683
          (setq magit-git-executable "${pkgs.git}/bin/git")
          (add-hook 'git-commit-setup-hook 'flymake-aspell-setup)
          ;;(add-hook 'git-commit-setup-hook 'git-commit-turn-on-flyspell)

          ;; Define a custom transient menu option to fetch updates from upstream and remove local
          ;; branches that not longer have a tracking branch on the remote
          (transient-insert-suffix 'magit-fetch "p"
            '("P" "fetch, prune and remove local branches tracking 'gone' remotes" gp/magit-fetch-and-prune-gone-remotes))

          ;; http://whattheemacsd.com/setup-magit.el-01.html#comment-748135498
          ;; full screen magit-status
          ;;
          ;; Extended config here: https://jakemccrary.com/blog/2020/11/14/speeding-up-magit/
          (defadvice magit-status (around magit-fullscreen activate)
            (window-configuration-to-register :magit-fullscreen)
            ad-do-it
            (delete-other-windows))
          (defadvice magit-quit-window (after magit-restore-screen activate)
            (jump-to-register :magit-fullscreen))

          ;; Remove some hooks to make the magit status buffer faster? Still experimenting
          (remove-hook 'magit-status-sections-hook 'magit-insert-tags-header)
          (remove-hook 'magit-status-sections-hook 'magit-insert-status-headers)
          (remove-hook 'magit-status-sections-hook 'magit-insert-unpushed-to-pushremote)
          (remove-hook 'magit-status-sections-hook 'magit-insert-unpulled-from-pushremote)
          (remove-hook 'magit-status-sections-hook 'magit-insert-unpulled-from-upstream)
          (remove-hook 'magit-status-sections-hook 'magit-insert-unpushed-to-upstream-or-recent)
        '';
      };

      meow = {
        enable = true;
        config = ''
          (defun meow-setup ()
            (setq meow-cheatsheet-layout meow-cheatsheet-layout-qwerty)
            (meow-motion-overwrite-define-key
             '("j" . meow-next)
             '("k" . meow-prev)
             '("<escape>" . ignore))
            (meow-leader-define-key
             ;; SPC j/k will run the original command in MOTION state.
             '("j" . "H-j")
             '("k" . "H-k")
             ;; Use SPC (0-9) for digit arguments.
             '("1" . meow-digit-argument)
             '("2" . meow-digit-argument)
             '("3" . meow-digit-argument)
             '("4" . meow-digit-argument)
             '("5" . meow-digit-argument)
             '("6" . meow-digit-argument)
             '("7" . meow-digit-argument)
             '("8" . meow-digit-argument)
             '("9" . meow-digit-argument)
             '("0" . meow-digit-argument)
             '("/" . meow-keypad-describe-key)
             '("?" . meow-cheatsheet))
            (meow-normal-define-key
             '("0" . meow-expand-0)
             '("9" . meow-expand-9)
             '("8" . meow-expand-8)
             '("7" . meow-expand-7)
             '("6" . meow-expand-6)
             '("5" . meow-expand-5)
             '("4" . meow-expand-4)
             '("3" . meow-expand-3)
             '("2" . meow-expand-2)
             '("1" . meow-expand-1)
             '("-" . negative-argument)
             '(";" . meow-reverse)
             '("," . meow-inner-of-thing)
             '("." . meow-bounds-of-thing)
             '("[" . meow-beginning-of-thing)
             '("]" . meow-end-of-thing)
             '("a" . meow-append)
             '("A" . meow-open-below)
             '("b" . meow-back-word)
             '("B" . meow-back-symbol)
             '("c" . meow-change)
             '("d" . meow-delete)
             '("D" . meow-backward-delete)
             '("e" . meow-next-word)
             '("E" . meow-next-symbol)
             '("f" . meow-find)
             '("g" . meow-cancel-selection)
             '("G" . meow-grab)
             '("h" . meow-left)
             '("H" . meow-left-expand)
             '("i" . meow-insert)
             '("I" . meow-open-above)
             '("j" . meow-next)
             '("J" . meow-next-expand)
             '("k" . meow-prev)
             '("K" . meow-prev-expand)
             '("l" . meow-right)
             '("L" . meow-right-expand)
             '("m" . meow-join)
             '("n" . meow-search)
             '("o" . meow-block)
             '("O" . meow-to-block)
             '("p" . meow-yank)
             '("q" . meow-quit)
             '("Q" . meow-goto-line)
             '("r" . meow-replace)
             '("R" . meow-swap-grab)
             '("s" . meow-kill)
             '("t" . meow-till)
             '("u" . meow-undo)
             '("U" . meow-undo-in-selection)
             '("v" . meow-visit)
             '("w" . meow-mark-word)
             '("W" . meow-mark-symbol)
             '("x" . meow-line)
             '("X" . meow-goto-line)
             '("y" . meow-save)
             '("Y" . meow-sync-grab)
             '("z" . meow-pop-selection)
             '("'" . repeat)
             '("<escape>" . ignore)))

          (meow-setup)
        '';
      };

      minizinc-mode = {
        enable = true;
      };

      # multiple-cursors = {
      #   enable = true;
      #   bind = {
      #     "C-S-c C-S-c" = "mc/edit-lines";
      #     "C-c m" = "mc/mark-all-like-this";
      #     "C->" = "mc/mark-next-like-this";
      #     "C-<" = "mc/mark-previous-like-this";
      #   };
      # };

      nix-mode = {
        enable = true;
        mode = [ ''"\\.nix\\'"'' ];
        extraPackages = [
          pkgs.rnix-lsp
          pkgs.nixpkgs-fmt
        ];
        config = ''
          (setq nix-nixfmt-bin "${pkgs.nixpkgs-fmt}/bin/nixpkgs-fmt")

          ;;(add-hook 'nix-mode-hook 'eglot-ensure)
        '';
      };

      no-littering = {
        enable = true;
        demand = true;
        config = ''
          (setq custom-file (no-littering-expand-etc-file-name "custom.el"))
        '';
      };

      olivetti = {
        enable = true;
        command = [ "olivetti-mode" ];
        diminish = [ "olivetti-mode" ];
        bindLocal = {
          olivetti-mode-map = {
            "C-M-=" = "hydra-olivetti-width/body";
          };
        };

        config = ''
          (setq olivetti-body-width 110)
          (setq olivetti-minimum-body-width 80)
          (setq olivetti-recall-visual-line-mode-entry-state t)

          ;; Enable hl-line-mode for olivetti-mode
          (push 'hl-line-mode olivetti-mode-on-hook)

          (add-hook 'poly-markdown+r-mode-hook
            (lambda()
              (push 'olivetti-mode polymode-move-these-vars-from-old-buffer) ;; Doesn't seem to work!
              (olivetti-mode t)))
        '';
      };

      org = {
        enable = true;
        bind = {
          "C-c l" = "org-store-link";
          "C-c a" = "org-agenda";
          "C-C c" = "org-capture";
        };
        config = builtins.readFile ./org-config.el;
      };

      org-agenda = {
        enable = true;
        after = [ "org" ];
        defer = true;
        config = builtins.readFile ./org-agenda-config.el;
      };

      #org-chef = {
      #  enable = true;
      #  after = [ "org" ];
      #  defer = 5; # defer loading for 5 seconds
      #};

      # # TODO: look into alternatives for org journal. Using dailies from org-roam??
      # org-journal = {
      #   enable = true;
      #   after = [ "org" ];
      #   bind = {
      #     "C-c n j" = "org-journal-new-entry";
      #   };
      #   config = ''
      #     (setq org-journal-enable-agenda-integration t
      #           org-journal-file-type 'monthly)

      #     (setq org-journal-dir org-notes-directory)
      #     ;;(org-journal-date-prefix "* ")
      #     (setq org-journal-file-format "%Y-%m-%d.org")
      #     (setq org-journal-date-format "%A, %d %B %Y")


      #     (defun org-journal-file-header-func (time)
      #       "Custom function to create journal header."
      #       (concat
      #         (pcase org-journal-file-type
      #           (`daily "#+TITLE: Daily Journal\n#+STARTUP: showeverything")
      #           (`weekly "#+TITLE: Weekly Journal\n#+STARTUP: folded")
      #           (`monthly "#+TITLE: Monthly Journal\n#+STARTUP: folded")
      #           (`yearly "#+TITLE: Yearly Journal\n#+STARTUP: folded"))))

      #     (setq org-journal-file-header 'org-journal-file-header-func)
      #   '';
      # };

      # TODO verify the config for org-noter
      org-noter = {
        enable = true;
        command = [ "org-noter" ];
        after = [ "org" "pdf-view" ];
        config = ''
          (setq org-noter-notes-window-location 'other-frame      ; The WM can handle splits
                org-noter-always-create-frame nil                 ; Please stop opening frames
                org-noter-hide-other nil                          ; I want to see the whole file
                org-noter-notes-search-path (list org_notes)      ; Everything is relative to the main notes file
                org-noter-default-notes-file-names '("notes.org")
                org-noter-separate-notes-from-heading t
          )
        '';
      };

      org-ql = {
        enable = true;
        config = ''
          (require 'org-ql-search)
          (require 'org-ql-view)
        '';
      };

      org-roam = {
        enable = true;
        after = [ "emacsql" "emacsql-sqlite" ];
        bind = {
          "C-c n l" = "org-roam-buffer-toggle";
          "C-c n f" = "org-roam-node-find";
          "C-c n g" = "org-roam-graph";
          "C-c n i" = "org-roam-node-insert";
          "C-c n c" = "org-roam-capture";
          # Dailies
          "C-c n j" = "org-roam-dailies-goto-today";
        };
        extraPackages = [ pkgs.sqlite ];
        init = ''
          (setq org-roam-v2-ack t) ;; Now on org-roam v2
        '';
        config = ''
          (setq org-roam-directory org-notes-directory)
          (setq org-roam-db-location (f-join org-root-directory "org-roam.db"))
          (setq org-roam-dailies-directory "dailies")

          (setq org-roam-dailies-capture-templates
            '(("d" "default" entry
               "* %?"
               :if-new (file+head "%<%Y-%m-%d>.org" "#+title: %<%Y-%m-%d>\n"))))

          (org-roam-db-autosync-mode)

          (require 'org-roam-dailies)
        '';
      };

      org-roam-bibtex = {
        # TODO: complete this
        enable = false;
        after = [ "org-roam" ];
      };

      org-superstar = {
        enable = true;
        after = [ "org" ];
        hook = [ "(org-mode . (lambda () (org-superstar-mode 1)))" ];
      };

      ox-beamer = {
        enable = true;
        after = [ "org" ];
      };

      ox-reveal = {
        enable = true;
        after = [ "org" ];
        config = ''
          (setq org-reveal-root "https://revealjs.com/")
          (setq org-reveal-title-slide nil)
        '';
      };

      page-break-lines = {
        enable = true;
        diminish = [ "page-break-lines-mode" ];
      };

      pcre2el = {
        enable = true;
        config = "(pcre-mode)";
      };

      pdf-tools = {
        enable = true;
        defer = true;
        mode = [ ''("\\.pdf\\'" . pdf-view-mode)'' ];
        config = ''
          (pdf-tools-install)
        '';
      };

      poly-R = {
        enable = true;
        after = [ "polymode" "ess" ];
      };

      poly-noweb = {
        enable = true;
        after = [ "polymode" ];
      };

      polymode = {
        enable = true;
        #        mode = [
        #''("\\.Rnw\\'" . poly-noweb+r-mode)''
        #          ''("\\.Rtex\\'" . poly-noweb+r-mode)''
        #          ''("\\.Rlatex\\'" . poly-latex+R-mode)''
        #        ];
      };

      project = {
        enable = true;
        # package = epkgs: epkgs.elpaPackages.project.overrideAttrs(old: {
        #   version = "0.9.8";
        # }); # Need to update this version???
        command = [ "project-root" ];
        bindKeyMap = { "C-x p" = "project-prefix-map"; };
        bindLocal.project-prefix-map = { "m" = "magit-project-status"; };
        config = ''
          (add-to-list 'project-switch-commands '(magit-project-status "Magit") t)
        '';
      };

      pulsar = {
        # https://protesilaos.com/emacs/pulsar
        enable = true;
        config = ''
(setq pulsar-pulse t)
(setq pulsar-delay 0.055)
(setq pulsar-iterations 10)
(setq pulsar-face 'pulsar-magenta)
(setq pulsar-highlight-face 'pulsar-yellow)

(pulsar-global-mode 1)

(let ((map global-map))
  (define-key map (kbd "C-x l") #'pulsar-pulse-line)
  (define-key map (kbd "C-x L") #'pulsar-highlight-line))

(add-hook 'next-error-hook #'pulsar-pulse-line)

(add-hook 'minibuffer-setup-hook #'pulsar-pulse-line-blue)

;; integration with the `consult' package:
(add-hook 'consult-after-jump-hook #'pulsar-recenter-top)
(add-hook 'consult-after-jump-hook #'pulsar-reveal-entry)

;; integration with the built-in `imenu':
(add-hook 'imenu-after-jump-hook #'pulsar-recenter-top)
(add-hook 'imenu-after-jump-hook #'pulsar-reveal-entry)
        '';
      };

      rainbow-delimiters = {
        enable = true;
        diminish = [ "rainbow-delimiters-mode" ];
        hook = [
          "(prog-mode . rainbow-delimiters-mode)"
          "(TeX-update-style . rainbow-delimiters-mode)"
        ];
        config = ''
          (set-face-attribute 'rainbow-delimiters-unmatched-face nil
                              :foreground "red"
                              :inherit 'error
                              :box t)
        '';
      };

      restclient = {
        enable = true;
        command = [ "restclient-mode" ];
        mode = [ ''("\\.http\\'" . restclient-mode)'' ];
      };

      rust-mode = {
        enable = true;
        mode = [ ''"\\.rs\\'"'' ];
        command = [ "rust-mode" ];
        hook = [
          #"(rust-mode . eglot-ensure)"
          "(rust-mode . lsp-deferred)"
        ];
        extraPackages = [
          pkgs.rust-analyzer
        ];
      };

      s = { enable = true; };

      scala-mode = {
        enable = true;
        mode = [
          ''("\\.scala\\'" . scala-mode)''
          ''("\\.sbt\\'" . scala-mode)''
        ];
        hook = [
          # "(scala-mode . eglot-ensure)"
          "(scala-mode . lsp-deferred)"
        ];
        extraPackages = [
          pkgs.metals # language server
        ];
      };

      # Manage the ssh-agent on the system by loading identities if and when required
      ssh-agency = {
        enable = true;
      };

      savehist = {
        enable = true;
        init = ''
          (savehist-mode)
        '';
      };

      # This will probably be obsolete in Emacs 30
      treesit-auto = {
        enable = true;
        config = ''
          (setq treesit-auto-install nil)
          (treesit-auto-add-to-auto-mode-alist 'all)
          (global-treesit-auto-mode)
        '';
      };

      vterm = {
        enable = true;
        config = ''
          (setq crux-term-func #'vterm)
        '';
      };

      warnings = {
        #TODO: needed?
        enable = true;
      };

      # web-mode = {
      #   enable = true;
      #   extraPackages = [
      #     pkgs.nodePackages.astro-language-server
      #     pkgs.nodePackages.typescript
      #   ];
      #   config = ''
      #     (setq web-mode-enable-front-matter-block t)

      #     (define-derived-mode astro-mode web-mode "astro")
      #     (setq auto-mode-alist
      #       (append '((".*\\.astro\\'" . astro-mode))
      #         auto-mode-alist))

      #     (with-eval-after-load 'eglot
      #       (add-to-list 'eglot-server-programs
      #         `(astro-mode . ("${pkgs.nodePackages.astro-language-server}/bin/astro-ls" "--stdio" :initializationOptions (:typescript (:tsdk "${pkgs.nodePackages.typescript}/lib/node_modules/typescript/lib"))))))
      #   '';
      # };

      wgrep = {
        enable = true;
      };

      which-key = {
        enable = true;
        config = ''
          ;; Allow C-h to trigger which-key before it is done automatically
          (setq which-key-show-early-on-C-h t)

          ;; make sure which-key doesn't show normally but refreshes quickly after it is triggered.
          (setq which-key-idle-delay 10000)
          (setq which-key-idle-secondary-delay 0.05)
          (which-key-mode 1)
        '';
      };

      writegood-mode = {
        enable = true;
        config = ''
          (add-hook 'TeX-update-style-hook #'writegood-mode)
          (add-to-list 'writegood-weasel-words "actionable")
        '';
      };

      yaml-mode = {
        enable = true;
        mode = [ ''"\\.ya?ml\\'"'' ];
      };

      yasnippet = {
        enable = true;
        diminish = [ "yas-minor-mode" ];
        command = [ "yas-global-mode" "yas-minor-mode" "yas-expand-snippet" ];
        hook = [
          # Yasnippet interferes with tab completion in ansi-term.
          "(term-mode . (lambda () (yas-minor-mode -1)))"
          "(yas-minor-mode . (lambda () (yas-activate-extra-mode 'fundamental-mode)))"
        ];
        config = "(yas-global-mode 1)";
      };

      yasnippet-snippets = {
        enable = true;
        after = [ "yasnippet" ];
      };


      # Completion
      all-the-icons = {
        enable = true;
      };

      all-the-icons-completion = {
        enable = true;
        after = [ "marginalia" "all-the-icons" ];
        hook = [ "(marginalia-mode . all-the-icons-completion-marginalia-setup)" ];
        config = ''
          (all-the-icons-completion-mode)
        '';
      };

      marginalia = {
        enable = true;
        after = [ "vertico" ];
        config = ''
          (setq marginalia-max-relative-age 0)

          ;; Must be in the :init section of use-package such that the mode gets
          ;; enabled right away. Note that this forces loading the package.
          (marginalia-mode)

          ;; Enable richer annotations for M-x.
          ;; Only keybindings are shown by default, in order to reduce noise for this very common command.
          ;; * marginalia-annotate-symbol: Annotate with the documentation string
          ;; * marginalia-annotate-command-binding (default): Annotate only with the keybinding
          ;; * marginalia-annotate-command-full: Annotate with the keybinding and the documentation string
          ;; (setf (alist-get 'command marginalia-annotate-alist) #'marginalia-annotate-command-full)
        '';
      };

      vertico = {
        enable = true;
        config = ''
          ;; Prefix the current candidate with “» ”. From
          ;; https://github.com/minad/vertico/wiki#prefix-current-candidate-with-arrow
          (advice-add #'vertico--format-candidate :around
            (lambda (orig cand prefix suffix index _start)
              (setq cand (funcall orig cand prefix suffix index _start))
              (concat
               (if (= vertico--index index)
                   (propertize "» " 'face 'vertico-current)
                 "  ")
               cand)))

          (setq vertico-count 13   ;; Number of candidates to display
                vertico-cycle nil)

          (vertico-mode)
        '';
      };

      orderless = {
        enable = true;
        config = ''
          (setq completion-styles '(orderless flex))
                ;;completion-category-overrides '((eglot (styles . (orderless flex))))) ;; https://github.com/minad/corfu/issues/136
        '';
      };

      corfu = {
        enable = true;
        config = ''
          (setq corfu-auto t        ;; Only use `corfu' when calling `completion-at-point' or `indent-for-tab-command'
                corfu-auto-prefix 2
                corfu-auto-delay 0.25

                corfu-min-width 80
                corfu-max-width corfu-min-width       ; Always have the same width
                corfu-count 14
                corfu-scroll-margin 4
                corfu-cycle nil)

          (global-corfu-mode)
        '';
      };

      kind-icon = {
        enable = true;
        after = [ "corfu" ];
        config = ''
          (setq kind-icon-use-icons t
                kind-icon-default-face 'corfu-default    ;; Have background color be the same as `corfu' face background
                kind-icon-blend-background nil           ;; Use midpoint color between foreground and background colors ("blended")?
                kind-icon-blend-frac 0.08)

          ;; Enable 'kind-icon'
          (add-to-list 'corfu-margin-formatters #'kind-icon-margin-formatter)
        '';
      };

      cape = {
        enable = true;
      };
    };
  };

  # home.file.".emacs.d/init.el".text = lib.mkAfter ''
  #   (load "${pkgs.fetchFromGitHub {
  #     owner = "seanfarley";
  #     repo = "emacs-bitwarden";
  #     rev = "02d6410003a42e7fbeb4aa109aba949eea553706";
  #     sha256 = "sha256-ooLgOwpJX9dgkWEev9xmPyDVPRx4ycyZQm+bggKAfa0=";
  #   }}/bitwarden.el")
  # '';
}
