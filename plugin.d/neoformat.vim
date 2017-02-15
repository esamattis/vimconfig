let g:neoformat_javascript_prettier = {
    \ 'exe': 'prettier-config',
    \ 'args': ['--stdin'],
    \ 'stdin': 1,
    \ }

let g:neoformat_enabled_javascript = ['prettier']

autocmd BufWritePre *.js exe ":Neoformat"
