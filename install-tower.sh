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

