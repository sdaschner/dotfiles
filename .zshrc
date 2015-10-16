# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="robbyrussell"
ZSH_THEME="afowler"

plugins=(git vi-mode)

# User configuration

export PATH="/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl"

source $ZSH/oh-my-zsh.sh

echo -ne "\e]12;yellow\007"

# Aliases
alias ll='ls -al --color=auto'

# Key bindings
bindkey -M viins 'jk' vi-cmd-mode
bindkey '^R' history-incremental-search-backward

zle-line-finish zle-line-init zle-keymap-select () {
    if [ $KEYMAP = vicmd ]; then
        echo -ne "\e[2 q"
    else
        echo -ne "\e[5 q"
    fi
}
