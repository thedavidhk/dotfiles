#!/bin/bash

DEST="$HOME"
SOURCE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# Link dotfiles
for DOTFILE in $SOURCE/dist/.{bash_profile,bashrc,inputrc,dotfiles,tmuxrc,vim}; do
    ln -fsv $DOTFILE $DEST
done

if [ $1 != "nogit" ]; then
    # Setup .gitconfig
    read -p "Name for gitconfig: " username
    read -p "Email for gitconfig: " email
    cp $SOURCE/dist/.gitconfig $DEST/
    sed -i "s/<name>/$username/g" $DEST/.gitconfig
    sed -i "s/<email>/$email/g" $DEST/.gitconfig
fi

# Setup neovim
nvim_config="${DEST}/.config/nvim/init.vim"
echo "set runtimepath^=~/.vim runtimepath+=~/.vim/after" > "$nvim_config"
echo "let &packpath = &runtimepath" >> "$nvim_config"
echo "source ~/.vim/vimrc" >> "$nvim_config"

# Install vim plugins
#$SOURCE/install_vim_plugins.sh

source $DEST/.bashrc
