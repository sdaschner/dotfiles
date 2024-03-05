# clears the shell and displays the current dir
clear-ls-all() {
    clear
    exa -al
    zle reset-prompt
}
zle -N clear-ls-all


# clears the shell and displays the dir tree with level 2
clear-tree-2() {
    clear
    tree -L 2
    zle reset-prompt
}
zle -N clear-tree-2


# clears the shell and displays the dir tree with level 3
clear-tree-3() {
    clear
    tree -L 3
    zle reset-prompt
}
zle -N clear-tree-3


# prints the current date in ISO 8601
print-current-date() {
  LBUFFER+=$(date -I)
}
zle -N print-current-date


# prints the current Unix timestamp
print-unix-timestamp() {
  LBUFFER+=$(date +%s)
}
zle -N print-unix-timestamp


# git status
git-status() {
    clear
    git status
    zle reset-prompt
}
zle -N git-status


# appends the clipboard contents to the buffer
vi-append-clip-selection() {
  char=${RBUFFER:0:1}
  RBUFFER=${RBUFFER:1}
  RBUFFER=$char$(clippaste)$RBUFFER;
}
zle -N vi-append-clip-selection


bindkey '^K' clear-ls-all
bindkey '^J' clear-tree-2
bindkey '^H' clear-tree-3
bindkey '^T' print-current-date
bindkey '^[^T' print-unix-timestamp
bindkey '^G' git-status

# bind for all, incl. VIM mode
bindkey -a "^O" copybuffer
bindkey -a " p" vi-append-clip-selection
