(define (script-fu-film-processor inImage inLayer gamma isBW isSlide)
  ;(gimp-message-set-handler CONSOLE)
  ;(gimp-message (string-append "highlights " (number->string highlights)))

  (if (= isBW TRUE)
    (gimp-drawable-desaturate inLayer DESATURATE-LUMINANCE)
  )
  (if (= isSlide FALSE)
      (gimp-drawable-invert inLayer FALSE)
  )
  (gimp-drawable-levels-stretch inLayer)

  ; optionally apply exposure adjustment
  (if (not (= gamma 100))
      (let*  (g (/ gamma 100))
            (gimp-message (string-append "gamma " (number->string g)))
            ; drawable channel low-input high-input clamp-input gamma low-output high-output clamp-output
            (gimp-drawable-levels inLayer HISTOGRAM-VALUE 0.0 1.0 FALSE g 0.0 1.0 FALSE)
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
  SF-ADJUSTMENT "Exposure Adjustment"
      (list 100 ;value
            10  ;lower
            1000;upper
            5   ;step inc
            10  ;page inc
            0   ;digits
            SF-SLIDER)
  SF-TOGGLE "Black & White" FALSE
  SF-TOGGLE "Slide" FALSE
)

(script-fu-menu-register
  "script-fu-film-processor"
  "<Image>/Colors"
)
