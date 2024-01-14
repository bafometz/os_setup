#!/bin/sh

cd go 
sh install.sh
cd ../

cd fonts
sh install.sh
cd ../

cd FontPatcher
python font-patcher
cd ../