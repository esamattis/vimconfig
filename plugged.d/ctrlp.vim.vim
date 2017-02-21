
let s:mode = ""


function s:FileDir()
    let g:ctrlp_working_path_mode = 'c'
    let g:ctrlp_user_command = 'find %s -maxdepth 1 -type f'


    if s:mode != "dir"
        CtrlPClearAllCaches
    endif

    let s:mode = "dir"

    CtrlP
endfunction

function s:GitRepo()
    let g:ctrlp_working_path_mode = 'r'
    " let g:ctrlp_user_command = 'find %s -type f'
    let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

    if s:mode != "project"
        CtrlPClearAllCaches
    endif

    let s:mode = "project"
    CtrlP
endfunction

nnoremap <leader>f :call <sid>FileDir()<CR>
nnoremap <leader>t :call <sid>GitRepo()<CR>
nnoremap <leader>m :CtrlPBuffer<CR>

" Just disable the default ctrlp mapping. Miniyank is mapped to it.
let g:ctrlp_map = ''
