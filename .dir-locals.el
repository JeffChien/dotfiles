((org-mode . ((defun resolve-path (filename)
                "Construct final path with property 'basedir'"
               (concat (org-entry-get nil "basedir" t) "/" filename))
              )))
