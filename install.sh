#!/bin/bash

DEST="$HOME"
SOURCE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# Link dotfiles
for DOTFILE in {bash_profile,bashrc,inputrc,tmuxrc}; do
    ln -fsv $SOURCE/$DOTFILE $DEST/.$DOTFILE
done

if [[ $1 != "nogit" ]]; then
    # Setup .gitconfig
    read -p "Name for gitconfig: " username
    read -p "Email for gitconfig: " email
    cp $SOURCE/gitconfig $DEST/.gitconfig
    sed -i "s/<name>/$username/g" $DEST/.gitconfig
    sed -i "s/<email>/$email/g" $DEST/.gitconfig
fi

# Setup neovim
nvim_config="${DEST}/.config/nvim/init.vim"
echo "set runtimepath^=~/.vim runtimepath+=~/.vim/after" > "$nvim_config"
echo "let &packpath = &runtimepath" >> "$nvim_config"
echo "source ~/.vim/vimrc" >> "$nvim_config"
if [[ -e $DEST/.vim ]]; then
    echo "$DEST/.vim already exists. Deleting..."
    rm $DEST/.vim
fi
ln -sv $SOURCE/vim $DEST/.vim

# Link components to .dotfiles directory
if [[ -e $DEST/.dotfiles ]]; then
    echo "$DEST/.dotfiles already exists. Deleting..."
    rm $DEST/.dotfiles
fi
ln -sv $SOURCE/components $DEST/.dotfiles

source $DEST/.bashrc
