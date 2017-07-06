;; Don't show the menu bar. It's just a waste of screen space.
(menu-bar-mode -1)

;; Stop emacs showing junk when you open it, or open a new scratch buffer.
(setq inhibit-startup-screen t)
(setq initial-scratch-message "")

;; Define my start-up layout. bash terminal in top-left, emacs config (for now) in bottom-left, empty buffer on the right.
(defun my-startup-layout ()
 (interactive)
 (delete-other-windows)
 (split-window-horizontally) ;; -> |
 (split-window-vertically) ;;  -> --
 (term "bash")
 (next-multiframe-window)
 (find-file "~/.emacs.d/init.el")
 (next-multiframe-window)
 (switch-to-buffer "**")
)

;; Execute my start-up layout.
(my-startup-layout )
