#!/bin/bash
SCRIPT=$( readlink -m $( type -p $0 ))
BASE_DIR=`dirname ${SCRIPT}`

echo "Make code folder"
mkdir ~/Code ~/Code/Java ~/Code/Python ~/Code/Common-Lisp ~/Code/Rust 

echo "Install Quicklisp"
./install-quicklisp.sh

echo "Install Rust"
./install-rust.sh

echo "Stow Everything"
./stow.sh 

echo "Create SSH-Key"
ssh-keygen -t rsa -b 4096 -C "andreas.ruscheinski@googlemail.com"
eval "$(ssh-agent -s)"
ssh.add ~/.ssh/id_rsa
