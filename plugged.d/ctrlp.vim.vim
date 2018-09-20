" Just disable the default ctrlp mapping. Miniyank is mapped to it.
let g:ctrlp_map = ''

let s:mode = ""


function s:FileDir()
    let g:ctrlp_working_path_mode = 'c'
    let g:ctrlp_user_command = 'find %s -maxdepth 1 -type f'

    " Always clear. It's fast.
    CtrlPClearAllCaches

    let s:mode = "dir"

    CtrlP
endfunction

function s:GitRepo(root)
    let g:ctrlp_working_path_mode = 'r'
    " let g:ctrlp_user_command = 'find %s -type f'
    let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

    if s:mode != "project"
        CtrlPClearAllCaches
    endif

    let s:mode = "project"

    if a:root == 1
        CtrlP
    else
        CtrlPCurWD
    endif
endfunction


if !executable('fzf')
    nnoremap <leader>t :call <sid>GitRepo(0)<CR>
    nnoremap <leader>T :call <sid>GitRepo(1)<CR>
endif

nnoremap <leader>f :call <sid>FileDir()<CR>
nnoremap <leader>m :CtrlPBuffer<CR>

