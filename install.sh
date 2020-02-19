#!/bin/bash

DEST0="$HOME"
SOURCE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# Link dotfiles
for DOTFILE in $SOURCE/dist/.{bash_profile,bashrc,inputrc,gitconfig,dotfiles}; do
    ln -fsv $DOTFILE $DEST0
done

# Install vim plugins
#$SOURCE/install_vim_plugins.sh

source $DEST0/.bashrc
