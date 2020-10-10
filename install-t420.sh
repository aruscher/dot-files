#!/bin/bash
SCRIPT=$( readlink -m $( type -p $0 ))
BASE_DIR=`dirname ${SCRIPT}`

echo "Make code folder"
mkdir ~/Code ~/Code/Java ~/Code/Python ~/Code/Common-Lisp


echo "Link ZSH"
rm ~/.zshrc
ln -s -i $BASE_DIR/zshrc ~/.zshrc

echo "Link sbclrc"
rm ~/.sbclrc
ln -s -i $BASE_DIR/sbclrc ~/.sbclrc

echo "Link Keyboard file"
sudo mkdir -p /etc/X11/xorg.conf.d/
sudo cp $BASE_DIR/xorg-config/keyboard.conf /etc/X11/xorg.conf.d/00-keyboard.conf

echo "Link Touchpad file"
sudo cp $BASE_DIR/xorg-config/touchpad.conf /etc/X11/xorg.conf.d/30-touchpad.conf

echo "Link PCSPKR Blacklist"
sudo cp $BASE_DIR/modprobe-confg/nobeep.conf /etc/modprobe.d/nobeep.conf

echo "Create SSH-Key"
ssh-keygen -t rsa -b 4096 -C "andreas.ruscheinski@googlemail.com"
eval "$(ssh-agent -s)"
ssh.add ~/.ssh/id_rsa
