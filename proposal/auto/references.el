(TeX-add-style-hook
 "references"
 (lambda ()
   (LaTeX-add-bibitems
    "kaipio2006statistical"
    "hadamard"
    "stuart_2010"
    "liu2008monte"
    "chopin_2002"
    "bayes-tutorial")
   (LaTeX-add-environments
    '("function" LaTeX-env-args ["argument"] 0)
    '("procedure" LaTeX-env-args ["argument"] 0)))
 :bibtex)

