let g:neoformat_javascript_prettier = {
    \ 'exe': 'prettier-config',
    \ 'args': ['--stdin'],
    \ 'stdin': 1,
    \ }

let g:neoformat_enabled_javascript = ['prettier']

let g:epeli_neoformat_enabled = 1

command NeoformatDisable execute "let g:epeli_neoformat_enabled = 0"
command NeoformatEnable execute "let g:epeli_neoformat_enabled = 1"

function AutoFormat()
    if g:epeli_neoformat_enabled
        Neoformat
    endif
endfunction

autocmd BufWritePre *.js exe ":call AutoFormat()"
