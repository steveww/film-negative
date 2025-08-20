(define (script-fu-film-negative inImage inLayer autoExpose isBW)
  (gimp-message-set-handler CONSOLE)
  (gimp-selection-all inImage)
  (if (= isBW TRUE)
    (gimp-drawable-desaturate inLayer DESATURATE-LUMINANCE)
  )
  (gimp-drawable-levels-stretch inLayer)
  (gimp-drawable-invert inLayer FALSE)
  ; apply expose adjustment
  ;(gimp-message (number->string autoExpose))
  (if (not (= autoExpose 100))
      (let* ((expose (/ autoExpose 100)))
          (gimp-drawable-levels inLayer HISTOGRAM-VALUE 0.0 expose FALSE 1.0 0.0 1.0 FALSE)
      )
  )
  ; show the results
  (gimp-displays-flush inImage)

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
  SF-ADJUSTMENT "Auto Exposure" '(100 10 100 5 10 0 SF-SLIDER)
  SF-TOGGLE "Black & White" FALSE
)

(script-fu-menu-register
  "script-fu-film-negative"
  "<Image>/Colors/Modify"
)
