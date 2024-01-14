#!/bin/sh

: ${APPDIR:=/home/$USER/.local/bin}
: ${CONFIGDIR:=/home/$USER/.config/conky/}
: ${AUTOSTARTFILE:=/home/$USER/.profile}

kill $(ps aux | grep 'conky' | awk '{print $2}')
rm -f $APPDIR/conky-x86_64.AppImage
sed -i "/conky/d" $AUTOSTARTFILE
rm -rf $CONFIGDIR