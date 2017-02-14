let g:neoformat_javascript_prettier = {
    \ 'exe': 'prettier',
    \ 'args': ['--stdin', '--no-bracket-spacing', '--tab-width=4', '--trailing-comma', '--print-width=100'],
    \ 'stdin': 1,
    \ }

let g:neoformat_enabled_javascript = ['prettier']

autocmd BufWritePre *.js exe ":Neoformat"
