;;; init-haskell.el --- haskell -*- lexical-binding: t -*-
;;; Commentary:
;;

;;; Code:

(use-package haskell-mode
  :ensure t
  :mode ("\\.hs\\'" . haskell-mode)
  :custom
  (haskell-process-check-cabal-config-on-load nil)
  (haskell-process-suggest-add-package nil)
  (haskell-process-suggest-haskell-docs-imports nil)
  (haskell-process-suggest-hoogle-imports nil)
  (haskell-process-suggest-language-pragmas nil)
  (haskell-process-suggest-no-warn-orphans nil)
  (haskell-process-suggest-overloaded-strings nil)
  (haskell-process-suggest-restart nil))

(use-package dante
  :ensure t
  :hook (haskell-mode . dante-mode)
  :bind (:map haskell-mode-map
         ;; Compatible with lsp-mode keybindings
         ("C-c d" . dante-info)
         ("C-c C-c" . dante-eval-block))
  )

(provide 'init-haskell)

;;; init-haskell.el ends here
