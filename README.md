# Film Negative
GIMP script to help processing colour or B&W film negatives

This script pulls together a few steps to process a scan of a colour film negative,
correcting for the different Cyan Magenta Yellow sensitivities of the film stock.

The results may not be perfect but they will be close and additional tweaking can always be
done by hand in GIMP or Adobe Lightroom.

## Install

Open up GIMP settings/preferences, expand the `Folders` section then select `Scripts`.
There will be two directories listed in there. One for the system and one for the user.
Copy the `film-negative.scm` file into either of these directories. Restart GIMP if it's
already running.

Alternatively, there is an install script for Mac and Linux systems `deploy.sh`.

## Usage

The script will appear as the menu option Colours -> Film Processor in the GIMP main menu.
When activated it gives you three options:

**Auto Exposure** Will adjust the exposure. 100 = no adjustment. 50 = approx 2 stops brighter.

**Balck & White** Will convert the image to black and white (desaturate) before performing any other modifications. This is a must for black and white scans and optional for colour scans if you want to convert to black and white.

**Slide** For slide film which is colour positive, this will skip the invert step.

Load a colour negative scan in TIFF format; 48 bit is best.

It optionally performs `Invert` for negatives then `Auto Input Levels` for colour correction. Finally it chnages the file
extension to `jpg` and exports the file as a JPEG. The colour correction may not be 100% but it does provide a good
starting point for final tweaks.
