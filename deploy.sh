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
DIR="$DESTINATION/scripts"
if [ ! -d "$DIR" ]
then
    echo "Create scripts dir"
    mkdir "$DIR"
fi
echo "Copy script-fu"
cp *.scm "$DIR"

echo "Finished"

