#!/bin/bash


SCRIPT=$( readlink -m $( type -p $0 ))
BASE_DIR=`dirname ${SCRIPT}`
NAME=`basename ${SCRIPT}`

FONTS_PATH="$BASE_DIR/fonts"


print-install-menu() {
    echo "Debug: Base-Dir: $BASE_DIR"
    echo "Install Menu"
    echo "------------"
    print-menu-entry 1 Spacemacs
    print-menu-entry 2 Fonts
    print-menu-entry 0 All
}

print-menu-entry(){
    echo "$1" "$2"
}

read-install-option(){
    local option=""
    read -p "Option: " option
    echo "$option"
}

install (){
    if [ "$1" -eq 0 ]; then
        install-all
    elif [ "$1" -eq 1 ]; then
        install-spacemacs
    elif [ "$1" -eq 2 ]; then
        install-fonts
    fi
}

install-all(){
    echo "Install all"
    install-spacemacs
}

install-spacemacs(){
    echo "Install Spacemacs"
    sudo apt-get install emacs
    git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
}

install-fonts(){
    echo "Install Fonts"
    if [ -d ~/.fonts ]; then
        echo Fonts exists
        cp -i -R ~/.fonts/* $FONTS_PATH/
        rm -rf ~/.fonts
    fi
    ln -s -i $FONTS_PATH ~/.fonts
    fc-cache -fv
}

main(){
    print-install-menu
    local option=$(read-install-option)
    install $option
}

main
