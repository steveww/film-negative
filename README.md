# Film Negative
GIMP script to help processing colour or B&W film negatives

This script pulls together a few steps to process a scan of a colour, slide or B&W film.
Inverting in the case of negatives, desautrating for B&W.
Correcting for the different Cyan Magenta Yellow sensitivities of colour film stock.

The results may not be perfect but they will be close and additional tweaking can always be
done by hand in GIMP or other photo editing software.

There are two versions of this plugin, one for GIMP 2.10 and for the new 3.0. The 2.10 version
is written in `script-fu` do to it only supporting Python 2 which is obsolete. The script for
GIMP 3.0 is written in Python 3.

GIMP 3.0 introduced no destructive edits. The `dual-save.py` plugin saves the current image in both
XCF (GIMP native) and JPG for use on websites etc.

## Install

Open up GIMP 2.10 settings/preferences, expand the `Folders` section then select `Scripts`.
There will be two directories listed in there. One for the system and one for the user.
Copy the `film-negative.scm` file into either of these directories. Restart GIMP if it's
already running.

The same for GIMP 3.0 except looks for `Plug-ins`. Each script **must** be installed in its own
subdirectory and be executable. For examle .../plugins/foo/foo.py

Alternatively, there is an install script for Mac and Linux systems `deploy.sh`.

## Usage

The script will appear as the menu option Colours -> Film Negative in the GIMP main menu.
When activated it gives you three options:

**Auto Exposure** Will adjust the exposure. 100 = no adjustment. 50 = approx 2 stops brighter.

**Balck & White** Will convert the image to black and white (desaturate) before performing any other modifications. This is a must for black and white scans and optional for colour scans if you want to convert to black and white.

**Slide** For slide film which is colour positive, this will skip the invert step.

Load a colour negative scan in TIFF format; 48 bit is best.

It optionally performs `Desaturate` then `Invert` for negatives finally `Auto Input Levels` for colour correction.
The colour correction may not be 100% but it does provide a good starting point for final tweaks.

# TODO

* Set colour profile of JPG to sRGB before export.

