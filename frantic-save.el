;;; frantic-save.el --- Auto-save buffers immediately after each change. -*- lexical-binding: t -*-

;; Copyright © 2024 Reed Spool <reedwith2es@gmail.com>

;; Author: Reed Spool <reedwith2es@gmail.com>
;; URL: https://github.com/reedspool/frantic-save
;; Keywords: convenience
;; Version: 0.0.1
;; Package-Requires: ((emacs "26.1"))

;; This file is NOT part of GNU Emacs.

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Commentary:
;;
;; frantic-save auto-saves your buffers immediately after each change. It's a
;; more aggressive version of the built-in auto-save-visited-mode or the
;; super-save package's super-save-auto-save-when-idle setting. Both of those
;; wait to save until Emacs is idle, while frantic-save saves regardless of the
;; user's activity.
;;
;; WARNING: frantic-save is currently a Work In Progress, and may make your
;; system unusable in its current state. Probably don't use it.
;;
;;; Code:
(defgroup frantic-save nil
  "Immediately save buffers."
  :group 'tools
  :group 'convenience)

(defvar frantic-save-selected-buffer nil)

(setq auto-save-visited-predicate
      (lambda ()
        (eq (current-buffer) frantic-save-selected-buffer)))

(defun frantic-save-activate-this-buffer ()
  "Activate frantic saving to immediately save every change to this buffer."
  (interactive)
  (auto-save-mode +1)
  (setq auto-save-visited-interval 0.0001)
  (auto-save-visited-mode +1)
  (setq frantic-save-selected-buffer (current-buffer)))

(defun frantic-save-toggle-selected-buffer ()
  "Toggle the frantic-save-selected-buffer as the current buffer.

Sets the frantic-save-selected-buffer to this buffer. If it was already set to
this buffer, sets it to nil instead."
  (interactive)
  (setq frantic-save-selected-buffer
        (if (eq (current-buffer) frantic-save-selected-buffer)
            nil
          (current-buffer))))

(provide 'frantic-save)
;;; frantic-save.el ends here
