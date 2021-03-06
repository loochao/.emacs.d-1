;;; init-git.el --- Git is awesome -*- lexical-binding: t -*-

;;; Commentary:
;;

;;; Code:

(use-package transient
  :ensure t
  :bind (:map transient-map
         ;; Close transient with ESC
         ([escape] . transient-quit-one)))

;; The awesome git client
(use-package magit
  :ensure t
  :defer 1
  :bind (("C-x g" . magit-status)
         ("C-x M-g" . magit-dispatch))
  :custom
  ;; Supress message
  (magit-no-message '("Turning on magit-auto-revert-mode..."))
  (magit-ediff-dwim-show-on-hunks t)
  (magit-diff-refine-hunk t))

;; Todo integration
(use-package magit-todos
  :ensure t
  :after magit
  :bind (:map magit-todos-section-map
         ("j" . nil)
         :map magit-todos-item-section-map
         ("j" . nil))
  :hook (magit-status-mode . magit-todos-mode)
  :config
  ;; Supress the `jT' keybind warning
  (define-advice magit-todos-mode (:around (func &rest args))
    (cl-letf (((symbol-function 'message)
               (lambda (&rest _) nil)))
      (apply func args))))

;; Dont display empty groups
(use-package ibuffer
  :ensure nil
  :commands (ibuffer-switch-to-saved-filter-groups)
  :hook ((ibuffer-mode . ibuffer-auto-mode)
         (ibuffer-mode . (lambda ()
                           (ibuffer-switch-to-saved-filter-groups "Default"))))
  :custom
  (ibuffer-expert t)
  (ibuffer-movement-cycle nil)
  (ibuffer-show-empty-filter-groups nil)
  (ibuffer-saved-filter-groups
   '(("Default"
      ("Emacs" (or (name . "\\*scratch\\*")
                   (name . "\\*dashboard\\*")
                   (name . "\\*compilation\\*")
                   (name . "\\*Backtrace\\*")
                   (name . "\\*Packages\\*")
                   (name . "\\*Messages\\*")
                   (name . "\\*Customize\\*")))
      ("Programming" (or (derived-mode . prog-mode)
                         (mode . makefile-mode)
                         (mode . cmake-mode)))
      ("Text" (or (mode . org-mode)
                  (mode . markdown-mode)
                  (mode . gfm-mode)
                  (mode . rst-mode)
                  (mode . text-mode)))
      ("Mail" (or (mode . message-mode)
                  (mode . bbdb-mode)
                  (mode . mail-mode)
                  (mode . mu4e-compose-mode)))
      ("Dired" (mode . dired-mode))
      ("Magit" (name . "magit"))
      ("Help" (or (name . "\\*Help\\*")
                  (name . "\\*Apropos\\*")
                  (name . "\\*info\\*"))))
     ))
  )

;; NB `diff-hl' depends on `vc'
(use-package vc
  :ensure nil
  :custom
  (vc-follow-symlinks t)
  (vc-handled-backends '(Git)))

;; Highlight uncommitted changes using git
(use-package diff-hl
  :ensure t
  :hook ((after-init . (lambda ()
                         (global-diff-hl-mode)
                         (diff-hl-flydiff-mode)))
         (magit-pre-refresh-hook . diff-hl-magit-pre-refresh)
         (magit-post-refresh . diff-hl-magit-post-refresh)
         (dired-mode . diff-hl-dired-mode-unless-remote)))

;; Open current file in browser
(use-package browse-at-remote
  :ensure t
  :custom
  (browse-at-remote-add-line-number-if-no-region-selected nil)
  :bind (:map vc-prefix-map
         ("b" . bar-browse)
         ("c" . bar-to-clipboard)))

;; Pop up last commit information of current line
(use-package git-messenger
  :ensure t
  :bind (:map vc-prefix-map
         ("p" . git-messenger:popup-message)
         :map git-messenger-map
         ("m" . git-messenger:copy-message))
  :custom
  (git-messenger:show-detail t)
  (git-messenger:use-magit-popup t))

(use-package smerge-mode
  :ensure nil
  :defer t
  :requires transient
  :commands (transient-setup transient-prefix)
  :bind (:map smerge-mode-map
         ("C-c m" . my/smerge-menu))
  :config
  (define-transient-command my/smerge-menu
    "Smerge"
    [["Navigation"
      ("p" "prev" smerge-prev)
      ("n" "next" smerge-next)]
     ["Keep"
      ("b" "base"    smerge-keep-base)
      ("u" "upper"   smerge-keep-upper)
      ("l" "lower"   smerge-keep-lower)
      ("a" "all"     smerge-keep-all)
      ("c" "current" smerge-keep-current)]
     ["Diff"
      ("<" "base against upper"  smerge-diff-base-upper)
      ("=" "upper against lower" smerge-diff-upper-lower)
      (">" "base against lower"  smerge-diff-base-lower)
      ("R" "refine"              smerge-refine)
      ("E" "ediff"               smerge-ediff)]
     ["Other"
      ("C" "combine"   smerge-combine-with-next)
      ("r" "resolve"   smerge-resolve)
      ("k" "kill"      smerge-kill-current)
      ("h" "highlight" smerge-refine)]])
  )

(provide 'init-git)

;;; init-git.el ends here
