export ZSH=~/.oh-my-zsh

ZSH_THEME="afowler"
plugins=(git vi-mode oc copybuffer kubectl)

source $ZSH/oh-my-zsh.sh


# colors
echo -ne "\e]12;orange\007"
export LS_COLORS="rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:"
export EXA_COLORS="uu=38;5;255:gu=38;5;255:ur=38;5;255:uw=38;5;255:ue=38;5;255:wx=38;5;255:gr=38;5;250:gw=38;5;250:gx=38;5;250:tr=38;5;255:tw=38;5;255:tx=38;5;255:da=38;5;250:sn=32:sb=0:di=38;5;105"


# vim cursor
zle-line-finish zle-line-init zle-keymap-select () {
    if [ $TERM != linux ]; then
        if [ $KEYMAP = vicmd ]; then
            echo -ne "\e[2 q"
        else
            echo -ne "\e[5 q"
        fi
    fi
}


# key bindings
bindkey '^R' history-incremental-search-backward
bindkey '^S' history-incremental-search-forward
# enable Ctrl + S / Q
stty start undef
stty stop undef
setopt noflowcontrol
setopt extendedglob

autoload zmv


# start ssh-agent w/ git ssh key
eval $(keychain --eval --quiet)
