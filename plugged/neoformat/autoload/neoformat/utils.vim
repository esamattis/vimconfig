function! neoformat#utils#log(msg) abort
    if !exists('g:neoformat_verbose')
        let g:neoformat_verbose = 0
    endif
    if &verbose || g:neoformat_verbose
        return s:better_echo(a:msg)
    endif
endfunction

function! neoformat#utils#warn(msg) abort
    echohl WarningMsg | call s:better_echo(a:msg) | echohl NONE
endfunction

function! neoformat#utils#msg(msg) abort
    if exists('g:neoformat_only_msg_on_error') && g:neoformat_only_msg_on_error
        return
    endif
    return s:better_echo(a:msg)
endfunction

function! s:better_echo(msg) abort
    let msg = a:msg
    if type(a:msg) != type('')
        let msg = string(a:msg)
    endif
    echom 'Neoformat: ' . msg
endfunction
