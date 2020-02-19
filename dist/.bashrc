#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='[\u@\h \W]\$ '

# Resolve DOTFILES_DIR
if [ -d "$HOME/.dotfiles" ]; then
    DOTFILES_DIR="$HOME/.dotfiles"
else
    echo "Unable to find dotfiles, exiting."
    return
fi

# Source the dotfiles (order matters)
for DOTFILE in "$DOTFILES_DIR"/{functions,path,alias,conda,env}; do
    [ -f "$DOTFILE" ] && . "$DOTFILE"
done
