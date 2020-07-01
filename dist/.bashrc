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

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/david/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/david/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/david/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/david/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

