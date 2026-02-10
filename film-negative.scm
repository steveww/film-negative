(define (script-fu-film-processor inImage inLayer highlights shadows isBW isSlide)
  ;(gimp-message-set-handler CONSOLE)
  ;(gimp-message (string-append "highlights " (number->string highlights)))

  (if (= isBW TRUE)
    (gimp-drawable-desaturate inLayer DESATURATE-LUMINANCE)
  )
  (if (= isSlide FALSE)
      (gimp-drawable-invert inLayer FALSE)
  )
  (gimp-drawable-levels-stretch inLayer)

  ; optionally apply levels adjustment
  (if (or (not (= highlights 100)) (not (= shadows 0)))
      (let* (
             (h (/ highlights 100))
             (s (/ shadows 100))
             )
            ; drawable channel low-input high-input clamp-input gamma low-output high-output clamp-output
            (gimp-drawable-levels inLayer HISTOGRAM-VALUE s 1.0 FALSE 1.0 0.0 h FALSE)
      )
  )
  ; show the results
  (gimp-displays-flush inImage)
)

(script-fu-register
  "script-fu-film-processor"
  "Film Processor"
  "Automatically adjusts colour sensitivity and invert"
  "SteveWW"
  "(c) 2025"
  "1 September 2025"
  "*"
  SF-IMAGE "The Image" 0
  SF-DRAWABLE "The Layer" 0
  SF-ADJUSTMENT "Highlights Adjustment" '(100 10 100 5 10 0 SF-SLIDER)
  SF-ADJUSTMENT "Shadows Adjustment" '(0 0 90 5 10 0 SF-SLIDER)
  SF-TOGGLE "Black & White" FALSE
  SF-TOGGLE "Slide" FALSE
)

(script-fu-menu-register
  "script-fu-film-processor"
  "<Image>/Colors"
)
