#!/bin/sh

clear

read -p "Gimp Version <2/3>? " ANS

case $ANS in
    2)
        VERSION="2.10"
        SCRIPT="film-negative.scm"
        DIR="scripts"
        ;;
    3)
        VERSION="3.0"
        SCRIPT="film-negative.py"
        DIR="plug-ins/film-negative"
        ;;
    *)
        echo "Wrong version"
        echo "Bye"
        exit 1
        ;;
esac

case $(uname) in
    Darwin)
        DESTINATION="$HOME/Library/Application Support/GIMP/$VERSION/$DIR"
        ;;
    Linux)
        DESTINATION="$HOME/.config/GIMP/$VERSION/$DIR"
        ;;
    *)
        echo "Unknown system"
        echo "Bye"
        exit 1
        ;;
esac

if [ "$VERSION" = "3.0" -a ! -d "$DESTINATION" ]
then
    echo "Creating $DESTINATION"
    mkdir "$DESTINATION"
fi


read -p "Copy script to $DESTINATION <y/n>? " ANS
if [ "$ANS" = "y" ]
then
    cp "$SCRIPT" "$DESTINATION"
    echo "Done"
fi

