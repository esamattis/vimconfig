
if [ -x $(which ag) ]; then
    export FZF_DEFAULT_COMMAND='
      (git ls-tree -r --name-only HEAD ||
      ag -g "") 2> /dev/null'
else
    export FZF_DEFAULT_COMMAND='
      (git ls-tree -r --name-only HEAD ||
       find . -path "*/\.*" -prune -o -type f -print -o -type l -print |
          sed s/^..//) 2> /dev/null'
fi


