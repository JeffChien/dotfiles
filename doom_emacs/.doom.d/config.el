(setq user-full-name "Jeff Chien"
      user-mail-address "jeffchien13@gmail.com")

(setq doom-theme 'doom-tomorrow-night)
(defun reload-theme (frame)
  (with-selected-frame frame
    (if (display-graphic-p)
        (load-theme 'doom-dracula t)
      (load-theme 'wombat t))))
(add-hook 'after-make-frame-functions #'reload-theme)

(setq doom-font (font-spec :family "SauceCodePro Nerd Font Mono" :size 16)
      doom-variable-pitch-font (font-spec :family "Helvetica" :size 16)
      doom-big-font (font-spec :family "SauceCodePro Nerd Font Mono" :size 32))
(after! doom-themes
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t))
(custom-set-faces!
  '(font-lock-comment-face :slant italic)
  '(font-lock-keyword-face :slant italic))

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!

(use-package! org
  :config
  (setq org-directory "~/org/")

  ;; hide / * _ ~ markers
  (setq org-hide-emphasis-markers t)

  ;; make C-c C-j show headings in menu
  (setq org-goto-interface 'outline-path-completion)

  ;; structure template list
  (add-to-list 'org-structure-template-alist '("py" . "src python"))
  (add-to-list 'org-structure-template-alist '("sh" . "src shell"))
  (add-to-list 'org-structure-template-alist '("em" . "src emacs-lisp"))
)

(use-package! org-media-note
  :hook (org-mode . org-media-note-mode)
  :config
  (setq org-media-note-screenshot-image-dir (concat org-directory "assets"))
  )
(map! :leader
      :desc "media note controller"
      "m v" #'org-media-note-hydra/body)

(use-package! org-super-agenda
  :after org-agenda
  :init
  (setq org-super-agenda-groups '((:name "Today"
                                        :time-grid t
                                        :scheduled today)
                                  (:name "Due today"
                                        :deadline today)
                                  (:name "Important"
                                        :priority "A")
                                  (:name "Overdue"
                                        :deadline past)
                                  (:name "Due soon"
                                        :deadline future)
                                  (:name "Big Outcomes"
                                   :tag "bo")))
  :config
  (org-super-agenda-mode))

(use-package org-appear
  :ensure t
  :hook (org-mode . org-appear-mode)
  :custom
  (org-appear-autolinks t)
  )



(use-package which-key
  :config
  ;; show the popup window earlier
  (setq which-key-idle-delay 0.2)

  ;; this fix the suggestion list form which-key is partially covered by status line.
  ;; https://github.com/doomemacs/doomemacs/issues/5622
  (setq which-key-allow-imprecise-window-fit nil)
  )

;; dired will automatically refresh buffer to reflect changes which were made by other applications.
(setq global-auto-revert-non-file-buffers t)

(map! :map dired-mode-map
           :n "h" 'dired-up-directory
           :n "l" 'dired-find-file
           :n "-" 'dired-do-kill-lines
           )

(setq delet-by-moving-to-trash t
      trash-directory "~/.Trash")

(use-package beacon
  :diminish beacon-mode
  :config
  (beacon-mode 1))

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; reload the buffer to reflect changes make by other applicaton.
(global-auto-revert-mode 1)

;; no idea the default RET key doesn't work so I have to map it ot other key
(map! :map evil-multiedit-mode-map
      :leader
      :v "t s" #'evil-multiedit-toggle-or-restrict-region)
