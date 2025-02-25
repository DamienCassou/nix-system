;;; Directory Local Variables
;;; For more information see (info "(emacs) Directory Variables")

((nix-ts-mode . ((mode . my/eglot-format-on-save)
                 (eval eglot-ensure)))
 (js-ts-mode . ((mode . finsit-reformatters-eslintd-on-save)
                (eval eglot-ensure)
                (eval flymake-eslint-enable))))
