;;; doom-matugen-theme.el --- Matugen theme -*- lexical-binding: t; no-byte-compile: t; -*-
;;
;;; Commentary:
;;; Code:

(require 'doom-themes)


;;
;;; Variables

(defgroup doom-matugen-theme nil
  "Options for the `doom-matugen' theme."
  :group 'doom-themes)

(defcustom doom-matugen-brighter-modeline nil
  "If non-nil, more vivid colors will be used to style the mode-line."
  :group 'doom-matugen-theme
  :type 'boolean)

(defcustom doom-matugen-brighter-comments nil
  "If non-nil, comments will be highlighted in more vivid colors."
  :group 'doom-matugen-theme
  :type 'boolean)

(defcustom doom-matugen-comment-bg doom-matugen-brighter-comments
  "If non-nil, comments will have a subtle, darker background. Enhancing their
legibility."
  :group 'doom-matugen-theme
  :type 'boolean)

(defcustom doom-matugen-padded-modeline doom-themes-padded-modeline
  "If non-nil, adds a 4px padding to the mode-line. Can be an integer to
determine the exact padding."
  :group 'doom-matugen-theme
  :type '(choice integer boolean))

(eval-and-compile
  (defcustom doom-matugen-region-highlight t
    "Determines the selection highlight style. Can be 'frost, 'snowstorm or t
(default)."
    :group 'doom-matugen-theme
    :type 'symbol))


;;
;;; Theme definition

(def-doom-theme doom-matugen
    "A theme for Matugen."
  :family 'doom-matugen
  :background-mode 'dark

  ;; name        default   256       16
  ((bg         '("#131316" nil       nil            ))
   (bg-alt     '("#131316" nil       nil            ))
   (base0      '("#131316" "black" "black"))      ; 最黑
   (base1      '("#131316" "#1e1e1e" "brightblack"))  ; 很接近 bg
   (base2      '("#1b1b1f" "#2e2e2e" "brightblack"))
   (base3      '("#1f1f23" "#262626" "brightblack"))
   (base4      '("#45464f" "#3f3f3f" "brightblack"))  ; 中灰，常用作 subtle lines
   (base5      '("#8f909a" "#525252" "brightblack"))          ; comments / muted text 基础
   (base6      '("#c6c6d0" "#6b6b6b" "brightblack")) ; inactive / dim text
   (base7      '("#e4e2e6" "#979797" "brightblack"))       ; 稍亮的灰文字
   (base8      '("#303034" "#dfdfdf" "white"))
   (fg         '("#e4e2e6" "#e4e2e6" "#e4e2e6"        ))
   (fg-alt     '("#c6c6d0" "#c6c6d0" "brightwhite"  ))

   (grey       base4)
   (red        '("#ffaed9" "#ffaed9" "red"          ))
   (orange     '("#ffb59d" "#ffb59d" "brightred"    ))
   (green      '("#74daa3" "#74daa3" "green"        ))
   (teal       '("#4cd9df" "#8fcdff" "brightgreen"  ))
   (yellow     '("#ffb951" "#ffb951" "yellow"       ))
   (blue       '("#b5c4ff" "#b5c4ff" "brightblue"   ))
   (dark-blue  '("#b5c4ff" "#b5c4ff" "blue"         ))
   (magenta    '("#c9bfff" "#c9bfff" "magenta"      ))
   (violet     '("#ffafd1" "#ffafd1" "brightmagenta"))
   (cyan       '("#5fd4fe" "#5fd4fe" "brightcyan"   ))
   (dark-cyan  '("#8fcdff" "#8fcdff" "cyan"         ))

   ;; face categories -- required for all themes
   (highlight      blue)
   (vertical-bar   (doom-darken base1 0.2))
   (selection      dark-blue)
   (builtin        blue)
   (comments       (if doom-matugen-brighter-comments dark-cyan (doom-lighten base5 0.2)))
   (doc-comments   (doom-lighten (if doom-matugen-brighter-comments dark-cyan base5) 0.25))
   (constants      blue)
   (functions      cyan)
   (keywords       blue)
   (methods        cyan)
   (operators      blue)
   (type           teal)
   (strings        green)
   (variables      base7)
   (numbers        magenta)
   (region         (pcase doom-matugen-region-highlight
                     (`frost teal)
                     (`snowstorm base7)
                     (_ base4)))
   (error          red)
   (warning        yellow)
   (success        green)
   (vc-modified    orange)
   (vc-added       green)
   (vc-deleted     red)

   ;; custom categories
   (hidden     `(,(car bg) "black" "black"))
   (-modeline-bright doom-matugen-brighter-modeline)
   (-modeline-pad
    (when doom-matugen-padded-modeline
      (if (integerp doom-matugen-padded-modeline) doom-matugen-padded-modeline 4)))

   (region-fg
    (when (memq doom-matugen-region-highlight '(frost snowstorm))
      base0))

   (modeline-fg     'unspecified)
   (modeline-fg-alt base6)

   (modeline-bg
    (if -modeline-bright
        (doom-blend bg base5 0.2)
      `(,(doom-darken (car bg) 0.1) ,@(cdr base2))))
   (modeline-bg-l
    (if -modeline-bright
        (doom-blend bg base5 0.2)
      base1))
   (modeline-bg-inactive   `(,(doom-darken (car bg) 0.1)   ,@(cdr base2)))
   (modeline-bg-inactive-l `(,(doom-darken (car bg) 0.025) ,@(cdr base2))))


  ;;;; Base theme face overrides
  ((fringe :foreground teal)
   ((line-number &override) :foreground (doom-lighten 'base5 0.2))
   ((line-number-current-line &override) :foreground base7)
   ((font-lock-comment-face &override)
    :background (if doom-matugen-comment-bg (doom-lighten bg 0.05) 'unspecified))
   ((tab-line &override) :background modeline-bg :foreground blue)
   ((tab-line-tab-inactive &override) :foreground dark-blue)
   (mode-line
    :background modeline-bg :foreground modeline-fg
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg)))
   (mode-line-inactive
    :background modeline-bg-inactive :foreground modeline-fg-alt
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-inactive)))
   (mode-line-emphasis :foreground (if -modeline-bright base8 highlight))
   ((region &override) :foreground (or region-fg 'unspecified))

   ;;;; css-mode <built-in> / scss-mode
   (css-proprietary-property :foreground orange)
   (css-property             :foreground green)
   (css-selector             :foreground blue)
   ;;;; doom-modeline
   (doom-modeline-bar :background (if -modeline-bright modeline-bg highlight))
   (doom-modeline-project-root-dir :foreground base6)
   ;;;; elscreen
   (elscreen-tab-other-screen-face :background "#353a42" :foreground "#1e2022")
   ;;;; highlight-symbol
   (highlight-symbol-face :background (doom-lighten base4 0.1) :distant-foreground fg-alt)
   ;;;; highlight-thing
   (highlight-thing :background (doom-lighten base4 0.1) :distant-foreground fg-alt)
   ;;;; ivy
   ((ivy-current-match &override) :foreground (or region-fg 'unspecified) :weight 'semi-bold)
   ;;;; markdown-mode
   (markdown-markup-face :foreground base5)
   (markdown-header-face :inherit 'bold :foreground red)
   ((markdown-code-face &override) :background (doom-lighten base3 0.05))
   ;;;; mic-paren
   ((paren-face-match &override) :foreground bg :background teal :weight 'ultra-bold)
   ((paren-face-mismatch &override) :foreground base7 :background red :weight 'ultra-bold)
   ;;;; org <built-in>
   (org-hide :foreground hidden)
   ;;;; solaire-mode
   (solaire-mode-line-face
    :inherit 'mode-line
    :background modeline-bg-l
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-l)))
   (solaire-mode-line-inactive-face
    :inherit 'mode-line-inactive
    :background modeline-bg-inactive-l
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-inactive-l)))
   ;;;; vimish-fold
   ((vimish-fold-overlay &override) :inherit 'font-lock-comment-face :background base3 :weight 'light)
   ((vimish-fold-fringe &override)  :foreground teal))

  ;;;; Base theme variable overrides-
  ())

;;; doom-matugen-theme.el ends here
