(define (script-fu-film-negative inImage inLayer)
  (gimp-selection-all inImage)
  (gimp-drawable-levels-stretch inLayer)
  (gimp-drawable-invert inLayer FALSE)
  ; show the results
  (gimp-displays-flush inImage)

  (gimp-message-set-handler CONSOLE)
  (let* (
          ; filename is a list - car gets the first element
          (filename (car(gimp-image-get-filename inImage)))
          (exportfile (morph-filename filename "jpg"))
      )

    ;(gimp-message exportfile)
    (file-jpeg-save RUN-INTERACTIVE inImage inLayer exportfile exportfile 0.95 0.0 1 1 "GIMP" 2 1 0 0)
  )
)

(define (morph-filename orig-name new-ext)
  (let* ((buffer (vector "" "" "")))
    (if (re-match "^(.*)[.]([^.]+)$" orig-name buffer)
      (string-append (substring orig-name 0 (car (vector-ref buffer 2))) new-ext)
      )
    )
  )


(script-fu-register
  "script-fu-film-negative"
  "Colour Negative"
  "Automatically adjusts colour sensitivity and invert"
  "SteveWW"
  "(c) 2025"
  "1 September 2025"
  "*"
  SF-IMAGE "The Image" 0
  SF-DRAWABLE "The Layer" 0
)

(script-fu-menu-register
  "script-fu-film-negative"
  "<Image>/Colors/Modify"
)
