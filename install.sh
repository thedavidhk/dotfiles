#!/bin/bash

DEST="$HOME"
SOURCE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# Link dotfiles
for DOTFILE in $SOURCE/dist/.{bash_profile,bashrc,inputrc,dotfiles}; do
    ln -fsv $DOTFILE $DEST
done

# Setup .gitconfig
read -p "Name for gitconfig: " username
read -p "Email for gitconfig: " email
cp $SOURCE/dist/.gitconfig $DEST/
sed -i "s/<name>/$username/g" $DEST/.gitconfig
sed -i "s/<email>/$email/g" $DEST/.gitconfig

# Install vim plugins
#$SOURCE/install_vim_plugins.sh

source $DEST/.bashrc
