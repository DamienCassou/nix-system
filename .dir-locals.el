;;; Directory Local Variables            -*- no-byte-compile: t -*-
;;; For more information see (info "(emacs) Directory Variables")

((js-ts-mode . ((mode . finsit-reformatters-eslintd-on-save)
                (eval . (eglot-ensure))
                (eval . (flymake-eslint-enable))))
 (nix-ts-mode . ((mode . nixfmt-on-save)
                 (eval . (eglot-ensure)))))
