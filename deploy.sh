#!/bin/sh

case $(uname) in
    Darwin)
        DESTINATION="$HOME/Library/Application Support/GIMP/2.10/scripts"
        ;;
    Linux)
        DESTINATION="$HOME/.config/GIMP/2.10/scripts"
        ;;
    *)
        echo "Unknown system"
        echo "Bye"
        exit 1
        ;;
esac

echo "Copying script to $DESTINATION"
cp film-negative.scm "$DESTINATION"
