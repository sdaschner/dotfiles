;; Thanks to https://superuser.com/questions/782416/how-can-i-switch-colors-using-keyboard-shortcuts-in-gimp
;;
;; script-fu to cycle between a set of foreground colors
;; edit the variable colors to modify the set
;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License.

(define (script-fu-cycle-foreground-color)

 (define colors (list '(0 0 0) '(255 0 0) '(0 200 0) '(0 0 255) '(240 240 0)))

 (define list-index
  (lambda (e lst)
  (if (null? lst)
   -1
   (if (equal? (car lst) e)
     0
     (if (= (list-index e (cdr lst)) -1)
      -1
      (+ 1 (list-index e (cdr lst)))
     )
    )
   )
  )
 )


 (gimp-context-set-foreground (list-ref colors (modulo (+ 1 (list-index (car (gimp-context-get-foreground)) colors)) (length colors))))

 (gimp-displays-flush)
)

(script-fu-register "script-fu-cycle-foreground-color"
         _"<Image>/Colors/Cycle FG"
         _"Cycles foreground color"
         "Jan Marchant"
         "Jan Marchant"
         "January 2015"
         "*"
)
