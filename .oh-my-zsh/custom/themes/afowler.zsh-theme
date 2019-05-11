if [ $UID -eq 0 ]; then CARETCOLOR="red"; else CARETCOLOR="blue"; fi

local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"

# show up to 3 parent dirs, except ~, resolve all other dir aliases
function collapse_pwd {
    curr_pwd=$(pwd | sed -e "s,^$HOME,~,")
    relevant_slashes=$(expr $(echo $curr_pwd| tr -d -c /|wc -c) - 1)
    echo $curr_pwd| cut -d / -f$(($relevant_slashes>0?$relevant_slashes:1))-
}

PROMPT='%{${fg[green]}%}$(collapse_pwd) $(git_prompt_info)%{${fg_bold[$CARETCOLOR]}%}»%{${reset_color}%} ' #${PWD/#$HOME/~}

RPS1="${return_code}"

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[yellow]%}‹"
ZSH_THEME_GIT_PROMPT_SUFFIX="› %{$reset_color%}"
