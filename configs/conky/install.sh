#!/bin/sh

: ${APPDIR:=/home/$USER/.local/bin}
: ${CONFIGDIR:=/home/$USER/.config/conky}
: ${AUTOSTARTFILE:=/home/$USER/.profile}

_msg() {
    echo "=>" "$@"
}

_rm() {
    # removes parent directories if empty
    _sudo rm -rf "$1"
    _sudo rmdir -p "$(dirname "$1")" 2>/dev/null || true
}

_sudo() {
    if [ -w "$DESTDIR" ] || [ -w "$(dirname "$DESTDIR")" ]; then
        "$@"
    else
        sudo "$@"
    fi
}

mkdir -p $APPDIR
mkdir -p $CONFIGDIR

wget https://github.com/brndnmtthws/conky/releases/download/v1.19.6/conky-x86_64.AppImage
chmod +x conky-x86_64.AppImage
mv conky-x86_64.AppImage $APPDIR

cp .conkyrc              $CONFIGDIR
cp .conkyrc_rss          $CONFIGDIR
cp cpu_name.sh           $CONFIGDIR
cp rss.sh                $CONFIGDIR
cp start_conky.sh        $CONFIGDIR

echo "#!/bin/bash" >> $CONFIGDIR/start_conky.sh
echo "\n" >>          $CONFIGDIR/start_conky.sh
echo "$APPDIR/conky-x86_64.AppImage -c $CONFIGDIR/.conkyrc &" >> $CONFIGDIR/start_conky.sh
echo "$APPDIR/conky-x86_64.AppImage -c $CONFIGDIR/.conkyrc_rss &" >> $CONFIGDIR/start_conky.sh
echo "$CONFIGDIR/start_conky.sh" >> $AUTOSTARTFILE

nohup bash $CONFIGDIR/start_conky.sh&

_msg "Conky installed"