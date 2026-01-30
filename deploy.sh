#!/bin/sh

set -e
#set -x

clear

read -p "Gimp Version <2/3>? " ANS

case $ANS in
    2)
        VERSION="2.10"
        DIR="scripts"
        ;;
    3)
        VERSION="3.0"
        DIR="plug-ins"
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

if [ "$VERSION" = "2.10" ]
then
    echo "$DESTINATION"
    read -p "Copy <y/n>? " ANS
    if [ "$ANS" = "y" ]
    then
        cp *.scm "$DESTINATION"
    fi
fi

if [ "$VERSION" = "3.0" ]
then
    echo "$DESTINATION"
    read -p "Copy <y/n>? " ANS
    if [ "$ANS" = "y" ]
    then
        for SCRIPT in *.py
        do
            DIR="$(basename $SCRIPT .py)"
            if [ ! -d "$DESTINATION/$DIR" ]
            then
                echo "Creating $DESTINATION/$DIR"
                mkdir "$DESTINATION/$DIR"
            fi

            cp $SCRIPT $DESTINATION/$DIR
        done
    fi

fi

