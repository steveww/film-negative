(define (script-fu-film-processor inImage inLayer gamma contrast isBW isSlide)
  ;(gimp-message-set-handler CONSOLE)
  ;(gimp-message (string-append "gamma " (number->string gamma)))

  (if (= isBW TRUE)
    (gimp-drawable-desaturate inLayer DESATURATE-LUMINANCE)
  )
  (if (= isSlide FALSE)
      (gimp-drawable-invert inLayer FALSE)
  )
  (gimp-drawable-levels-stretch inLayer)

  ; optionally apply exposure adjustment
  (unless (and (= gamma 0) (= contrast 0))
      (let*  (
              (inputlow 0.0)
              (inputhi 1.0)
              (outputlow 0.0)
              (outputhi 1.0)
              (c (/ contrast 100))
              ; gamma range 0.1 -> 10 with 1.0 as neutral
              (g (+ 1.0 (/ gamma 100))))
            ;(gimp-message (string-append "contrast " (number->string c)))
            ;(gimp-message (string-append "gamma " (number->string g)))

            (if (> c 0)
              (set! inputlow (+ inputlow c)) ;then
              (set! outputlow (- outputlow c)) ;else
            )
            (if (> c 0)
              (set! inputhi (- inputhi c)) ;then
              (set! outputhi (+ outputhi c)) ;else
            )

            ;(gimp-message (string-append "inputlow " (number->string inputlow)))
            ;(gimp-message (string-append "inputhi " (number->string inputhi)))
            ;(gimp-message (string-append "outputlow " (number->string outputlow)))
            ;(gimp-message (string-append "outputhi " (number->string outputhi)))

            ; drawable channel low-input high-input clamp-input gamma low-output high-output clamp-output
            (gimp-drawable-levels inLayer HISTOGRAM-VALUE inputlow inputhi FALSE g outputlow outputhi FALSE)
      ) ;let
  ) ;unless

  ; May be change the colour profile to sRGB
  ; gimp-directory is set to ~/.config/GIMP/3.0

  ; show the results
  (gimp-displays-flush)
)

(script-fu-register
  "script-fu-film-processor"
  "Film Processor"
  "Automatically adjusts colour sensitivity and invert"
  "SteveWW"
  "SteveWW (c) 2025"
  "1 September 2025"
  "*"
  SF-IMAGE "image" 0
  SF-DRAWABLE "drawable" 0
  SF-ADJUSTMENT "Mid Adjustment"
      (list 0 ;value
            -80  ;lower
            80 ;upper
            5   ;step inc
            10  ;page inc
            0   ;digits
            SF-SLIDER)
  SF-ADJUSTMENT "Contrast Adjustment"
      (list 0 ;value
            -20 ;lower
            20  ;upper
            1   ;step
            10 ;bug step
            0 ;digits
            SF-SLIDER)
  SF-TOGGLE "Black & White" FALSE
  SF-TOGGLE "Slide" FALSE
)

(script-fu-menu-register
  "script-fu-film-processor"
  "<Image>/Colors"
)

