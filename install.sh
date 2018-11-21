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

mkdir ~/.stumpwm.d/
ln -s -i ./stumpwm-config/init.lisp ~/.stumpwm.d/init.lisp

echo "Extend sbclrc to lookup user-code"
cat sbclrc >> ~/.sbclrc

echo "Copy Keyboard file"
sudo mkdir -p /etc/X11/xorg.conf.d/
sudo cp ./xorg-config/keyboard.conf /etc/X11/xorg.conf.d/00-keyboard.conf

echo "Copy Touchpad file"
sudo cp ./xorg-config/touchpad.conf /etc/X11/xorg.conf.d/30-touchpad.conf

echo "Blacklist PC-Speaker"
sudo cp ./modprobe-confg/nobeep.conf /etc/modprobe.d/nobeep.conf

echo "Create SSH-Key"
ssh-keygen -t rsa -b 4096 -C "andreas.ruscheinski@googlemail.com"
eval "$(ssh-agent -s)"
ssh.add ~/.ssh/id_rsa
