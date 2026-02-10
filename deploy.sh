#!/bin/sh

set -e
#set -x

clear

VERSION="3.0"
case $(uname) in
    Darwin)
        DESTINATION="$HOME/Library/Application Support/GIMP/$VERSION"
        ;;
    Linux)
        DESTINATION="$HOME/.config/GIMP/$VERSION"
        ;;
    *)
        echo "Unknown system"
        echo "Bye"
        exit 1
        ;;
esac

# copy script-fu
echo "Copy script-fu"
cp *.scm $DESTINATION/scripts

DIR="$DESTINATION/plug-ins/dual-save"
if [ ! -d $DIR ]
then
    echo "Create plugin directory"
    mkdir $DIR
fi

echo "Copy Python plugin"
cp dual-save.py $DIR

echo "Finished"

