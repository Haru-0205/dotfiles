;; -*- lexical-binding: t; -*-

(require 'package)

;; MELPA
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; Tab Width
(setq default-tab-width 2)

;; Line Number
(global-display-line-numbers-mode)

;; ring bell

(setq ring-bell-function 'ignore)

