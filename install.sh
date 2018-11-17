#!/bin/bash
SCRIPT=$( readlink -m $( type -p $0 ))
BASE_DIR=`dirname ${SCRIPT}`

echo "Make code folder"
mkdir ~/Code ~/Code/Java ~/Code/Python ~/Code/Common-Lisp 

rm ~/.spacemacs
rm ~/.zshrc

ln -s -i $BASE_DIR/spacemacs ~/.spacemacs
ln -s -i $BASE_DIR/zshrc ~/.zshrc

cat sbclrc >> ~/.sbclrc
