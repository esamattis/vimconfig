function! neoformat#formatters#typescript#enabled() abort
   return ['tsfmt']
endfunction

function! neoformat#formatters#typescript#tsfmt() abort
    return {
        \ 'exe': 'tsfmt',
        \ 'args': ['--stdin', '%:p'],
        \ 'stdin': 1
        \ }
endfunction
