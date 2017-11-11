
if [ -x $(which ag) ]; then
    export FZF_DEFAULT_COMMAND='ag -g ""'
else
    export FZF_DEFAULT_COMMAND='find . -path "*/\.*" -prune -o -type f -print -o -type l -print'
fi


export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND
