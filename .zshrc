export ZSH=~/.oh-my-zsh

ZSH_THEME="afowler"

plugins=(git vi-mode)

source $ZSH/oh-my-zsh.sh

echo -ne "\e]12;orange\007"

# Key bindings
bindkey -M viins 'jk' vi-cmd-mode
bindkey '^R' history-incremental-search-backward
bindkey '^S' history-incremental-search-forward

# Vim cursor
zle-line-finish zle-line-init zle-keymap-select () {
    if [ $TERM != linux ]; then
        if [ $KEYMAP = vicmd ]; then
            echo -ne "\e[2 q"
        else
            echo -ne "\e[5 q"
        fi
    fi
}

# Aliases
source ~/.aliases
