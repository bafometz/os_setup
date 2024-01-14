#!/bin/sh

: ${FONTDIR=$HOME/.local/share/fonts}

find /home/shantanu/processed/ -name '*.ttf ' -exec cp "{}" ${FONTDIR}  \;


# Reset font cache on Linux
if which fc-cache >/dev/null 2>&1 ; then
    echo "Resetting font cache, this may take a moment..."
    fc-cache -f "$font_dir"
fi