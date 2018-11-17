#!/bin/bash
SCRIPT=$( readlink -m $( type -p $0 ))
BASE_DIR=`dirname ${SCRIPT}`


rm ~/.spacemacs
rm ~/.zshrc

ln -s -i $BASE_DIR/spacemacs ~/.spacemacs
ln -s -i $BASE_DIR/zshrc ~/.zshrc
