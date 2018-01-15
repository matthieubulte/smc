(TeX-add-style-hook
 "proposal"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("algorithm2e" "ruled" "lined")))
   (TeX-run-style-hooks
    "latex2e"
    "article"
    "art10"
    "cite"
    "amssymb"
    "mathtools"
    "algorithm2e")
   (TeX-add-symbols
    "defeq")
   (LaTeX-add-labels
    "inverse-problem"
    "bayesian inverse problem"
    "def_posterior"
    "alg-metropolis-hastings"
    "is-approximation"
    "weights-approx"
    "alg-smc")
   (LaTeX-add-environments
    '("function" LaTeX-env-args ["argument"] 0)
    '("procedure" LaTeX-env-args ["argument"] 0))
   (LaTeX-add-bibliographies
    "references"))
 :latex)

