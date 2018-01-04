#!/bin/bash
SCRIPT=$( readlink -m $( type -p $0 ))
BASE_DIR=`dirname ${SCRIPT}`
NAME=`basename ${SCRIPT}`

FONTS_PATH="$BASE_DIR/fonts"
FILES_PATH="$BASE_DIR/files"
INSTALLER_PATH="$BASE_DIR/installer"

print-install-menu() {
    echo "Debug: Base-Dir: $BASE_DIR"
    echo "Install Menu"
    echo "------------"
    print-menu-entry 1 Spacemacs
    print-menu-entry 2 Fonts
    print-menu-entry 3 ZSH
    print-menu-entry 4 Python
    print-menu-entry 5 Lisp
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
    elif [ "$1" -eq 3 ]; then
        install-zsh
    elif [ "$1" -eq 4 ]; then
        install-python
    elif [ "$1" -eq 5 ]; then
        install-lisp
    fi
}

install-all(){
    echo "Install all"
    install-spacemacs
    install-fonts
    install-zsh
    install-python
    install-lisp
}

install-spacemacs(){
    echo "Install Spacemacs"
    sudo apt-get install git emacs
    git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
    ln -s -i $FILES_PATH/spacemacs ~/.spacemacs
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

install-python(){
    sudo apt-get install virtualenvwrapper
}

install-zsh(){
    sudo apt-get install zsh curl wget git
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    rm ~/.zshrc
    ln -s -i $FILES_PATH/zshrc ~/.zshrc
}

install-lisp(){
    sudo apt-get install sbcl
    sbcl --load $INSTALLER_PATH/quicklisp.lisp
}

main(){
    print-install-menu
    local option=$(read-install-option)
    install $option
}

main
