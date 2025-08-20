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

The script will appear as the menu option Colours -> Colour Negative in the GIMP main menu.
When activated it gives you two options:

**Auto Exposure** Will adjust the exposure. 100 = no adjustment. 50 = approx 2 stops brighter.

**Balck & White** Will convert the image to black and white (desaturate) before performing any other modifications. This is a must for black and white scans and optional for colour scans you want to convert to black and white.

Load a colour negative scan in TIFF format; 48 bit is best.

It performs `Auto Input Levels` for the colour correction then `Invert` to go from negative
to positive. Finally the JPEG export dialog will be displayed. Save at 95% quality.
Use `Save Defaults` to remember this setting.
