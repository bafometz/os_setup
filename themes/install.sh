#!/bin/sh

cd qt-creator
sh install.sh
cd ../

cd Nordic
sudo mkdir -p /usr/share/themes/Nordic
sudo mv extras assets gtk-2.0 gtk-3.0 gtk-4.0 xfwm4 /usr/share/themes/Nordic/

cd zuki-themes
sudo apt install gtk2-engines-murrine gtk2-engines-pixbuf ninja-build git meson sassc
meson build
sudo ninja -C build install

cd Greybird
sudo apt install autoconf libgdk-pixbuf2.0-dev libglib2.0-bin librsvg2-dev meson ruby-sass sassc
meson --prefix=/usr builddir
cd builddir
ninja
ninja install

cd arc-icon-theme
./autogen.sh --prefix=/usr
sudo make install
