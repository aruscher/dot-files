#!/bin/bash
SCRIPT=$( readlink -m $( type -p $0 ))
BASE_DIR=`dirname ${SCRIPT}`

echo "Make code folder"
mkdir ~/Code ~/Code/Java ~/Code/Python ~/Code/Common-Lisp

echo "Link spacemacs and zshrc and stumpwm"
rm ~/.spacemacs
rm ~/.zshrc
rm ~/.stumpwmrc

ln -s -i $BASE_DIR/spacemacs ~/.spacemacs
ln -s -i $BASE_DIR/zshrc ~/.zshrc
ln -s -i $BASE_DIR/stumpwmrc ~/.stumpwmrc

echo "Extend sbclrc to lookup user-code"
cat sbclrc >> ~/.sbclrc

echo "Copy Keyboard file"
sudo mkdir -p /etc/X11/xorg.conf.d/
cp ./keyboard.conf /etc//X11/xorg.conf.d/00-keyboar.conf
