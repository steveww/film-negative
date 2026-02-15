#!/usr/bin/env gimp-script-fu-interpreter-3.0

(define (script-fu-dual-save inImage inLayer quality)
    (let* (
          (filename (car (gimp-image-get-file inImage)))
          (exportfile (morph-filename filename "jpg"))
          (savefile (morph-filename filename "xcf"))
          (q (/ quality 100))
          )

          ;(gimp-message filename)
          ;(gimp-message exportfile)
          ;(gimp-message savefile)

          ; XCF
          (gimp-message "Saving XCF")
          (gimp-xcf-save RUN-NONINTERACTIVE inImage savefile)

          (gimp-message "Saving JPG")
          (file-jpeg-export
                          #:run-mode RUN-NONINTERACTIVE
                          #:image inImage
                          #:file exportfile
                          #:options -1
                          #:quality q
                          #:smoothing 0.0
                          #:optimize TRUE
                          #:progressive TRUE
                          #:cmyk FALSE
                          #:include-color-profile TRUE
                          #:include-comment FALSE
                          #:include-exif TRUE
                          #:include-iptc FALSE
                          #:include-xmp FALSE
                          #:sub-sampling "sub-sampling-1x1" ;best quality
                          #:baseline TRUE
                          #:restart 0
                          #:dct "integer")

          (gimp-message "Finished")
    )
    (gimp-image-clean-all inImage)
)

(define (morph-filename orig-name new-ext)
  (let* ((buffer (vector "" "" "")))
    (if (re-match "^(.*)[.]([^.]+)$" orig-name buffer)
      (string-append (substring orig-name 0 (car (vector-ref buffer 2))) new-ext)
    )
  )
)


(script-fu-register
  "script-fu-dual-save"
  "Dual Save"
  "Save XCF and JPG"
  "SteveWW"
  "(c) 2026"
  "1 September 2025"
  "*"
  SF-IMAGE "image" 0
  SF-DRAWABLE "drawable" 0
  SF-ADJUSTMENT "JPEG Quality"
    (list 95 ;value
          50 ;lower
          100 ;upper
          5 ;step inc
          10 ;page inc
          0 ;digits
          SF-SLIDER)
)

(script-fu-menu-register
  "script-fu-dual-save"
  "<Image>/File/[Save]"
)

