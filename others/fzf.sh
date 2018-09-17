export PATH=$HOME/.fzf/bin:$PATH

source $HOME/.fzf/shell/key-bindings.bash
source $HOME/.fzf/shell/completion.bash

if [ -x $(which fd) ]; then
    export FZF_DEFAULT_COMMAND='fd --type file --hidden --exclude .git'
elif [ -x $(which ag) ]; then
    export FZF_DEFAULT_COMMAND='ag -g ""'
else
    export FZF_DEFAULT_COMMAND='find . -path "*/\.*" -prune -o -type f -print -o -type l -print'
fi


export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND
