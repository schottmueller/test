(require 'package)
(setq package-user-dir (expand-file-name "./.packages"))
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(setq use-package-always-ensure t)

;; Initialize the package system
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

(use-package org :pin elpa)

(package-upgrade org)

(require 'ox-publish)

(message (org-version))

;; Customize the HTML output
(setq org-html-validation-link nil            ;; Don't show validation link
      org-html-head-include-scripts nil       ;; Use our own scripts
      org-html-head-include-default-style nil ;; Use our own styles
      org-html-head "<link rel=\"stylesheet\" href=\"https://cdn.simplecss.org/simple.min.css\" />")

;; Define the publishing project
(setq org-publish-project-alist
      (list
       (list "org-site:main"
             :recursive t
             :base-directory "./content"
             :publishing-function 'org-html-publish-to-html
             :publishing-directory "./public"
             :with-author nil           ;; Don't include author name
             :with-creator t            ;; Include Emacs and Org versions in footer
             :with-toc t                ;; Include a table of contents
             :section-numbers nil       ;; Don't include section numbers
             :time-stamp-file nil)))    ;; Don't include time stamp in file

;; Generate the site output
(org-publish-all t)

(message "Build complete!")
