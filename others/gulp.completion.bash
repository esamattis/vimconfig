#!/bin/bash
# Originally from https://github.com/Bash-it/bash-it/blob/c3d9c46ef832f808c929a22b36c8ef6dd45cb98a/completion/available/gulp.completion.bash
#
# Borrowed from grunt-cli
# http://gruntjs.com/
#
# Copyright (c) 2012 Tyler Kellen, contributors
# Licensed under the MIT license.
# https://github.com/gruntjs/grunt/blob/master/LICENSE-MIT
# Usage:
#
# To enable bash <tab> completion for gulp, add the following line (minus the
# leading #, which is the bash comment character) to your ~/.bashrc file:
#


gulp() {
    "$(_get_gulp_bin)" $@
}

_get_gulp_bin() {
    if [ -x "./node_modules/.bin/gulp" ]; then
        echo "$PWD/node_modules/.bin/gulp"
    else
        which gulp
    fi
}

# eval "$(gulp --completion=bash)"
# Enable bash autocompletion.
_gulp_completions() {
    # The currently-being-completed word.
    local cur="${COMP_WORDS[COMP_CWORD]}"
    # Grab tasks
    local compls=$(gulp --tasks-simple)
    # Tell complete what stuff to show.
    COMPREPLY=($(compgen -W "$compls" -- "$cur"))
}

complete -o default -F _gulp_completions gulp
