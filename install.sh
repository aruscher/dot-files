#!/bin/bash

print-install-menu() {
    echo "Install Menu"
    echo "------------"
    print-menu-entry 1 Spacemacs

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
    fi
}
install-all(){
    echo "Install all"
    install-spacemacs
}

install-spacemacs(){
    echo "Install Spacemacs"
}
main(){
    print-install-menu
    local option=$(read-install-option)
    install $option
}

main
