function! neoformat#formatters#php#enabled() abort
    return ['phpbeautifier', 'phpcbf']
endfunction

function! neoformat#formatters#php#phpbeautifier() abort
    return {
        \ 'exe': 'php_beautifier',
        \ }
endfunction

" function! neoformat#formatters#php#phpcbf() abort
"     return {
"         \ 'exe': 'phpcbf',
"         \ 'stdin': 1, 
"         \ }
" endfunction

function! neoformat#formatters#php#phpcbf() abort
    return {
        \ 'exe': 'sh',
        \ 'args': ['-c', 'phpcbf || true'],
        \ 'stdin': 1, 
        \ }
endfunction
