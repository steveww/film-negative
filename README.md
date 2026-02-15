# Film Negative

Currently V2 scripts which will run with GIMP 3.0.

GIMP script to help processing colour or B&W film negatives and slides.

This script pulls together a few steps to process a scan of a colour, slide or B&W film.
Inverting in the case of negatives, desautrating for B&W.
Correcting for the different Cyan Magenta Yellow sensitivities of colour film stock.

The results may not be perfect but they will be close and additional tweaking can always be
done by hand in GIMP or other photo editing software.

## Install


There is an install script for Mac and Linux systems `deploy.sh`.

## Usage

The script will appear as the menu option Colours -> Film Processor in the GIMP main menu.
When activated it gives you three options:

**Mid Adjustment** Will adjust the mid tones. 0 = no adjustment. Less than 0 will darken. Greater than 0 will lighten.

**Contrast Adjustment** Will adjust the contrast. 0 = no adjustment. Less than 0 will reduce contrast. Greater than 0 will increase contrast.

**Balck & White** Will convert the image to black and white (desaturate) before performing any other modifications. This is a must for black and white scans and optional for colour scans if you want to convert to black and white.

**Slide** For slide film which is colour positive, this will skip the invert step.

Load a colour negative scan in TIFF format; 48 bit is best.

It optionally performs `Desaturate` then `Invert` for negatives finally `Auto Input Levels` for colour correction.
The colour correction may not be 100% but it does provide a good starting point for final tweaks.

