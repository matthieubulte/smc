(TeX-add-style-hook
 "plan"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("inputenc" "utf8") ("algorithm2e" "ruled" "lined")))
   (TeX-run-style-hooks
    "latex2e"
    "article"
    "art10"
    "cite"
    "amssymb"
    "mathtools"
    "inputenc"
    "algorithm2e")
   (LaTeX-add-bibliographies
    "references"))
 :latex)

