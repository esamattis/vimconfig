" Search using git grep
"
" Ex. :GitGrep var foo
" Ex. :G var foo


" Using custom wrapper which ignores long lines. Ex. compiled Javascript
" bundles etc.
let g:gitgrepprg="git-grep-short-lines"
" let g:gitgrepprg="git\\ grep\\ -n"

let s:GitGrepWindowOpen = 0

function! GitGrep(args)

    " Override the current :grep command
    let grepprg_bak=&grepprg
    exec "set grepprg=" . g:gitgrepprg

    " Execute :grep with the function argument
    execute "silent! grep! '" . a:args . "'"

    " Open quickfix window to the bottom
    botright copen

    " Restore previous :grep command
    let &grepprg=grepprg_bak

    exec "redraw!"

    " Add buffer local shortcuts (q and esc) for closing the quickfix window
    nnoremap <buffer> <silent> q :call <sid>GitGrepClose()<CR>
    nnoremap <buffer> <silent> <esc> :call <sid>GitGrepClose()<CR>

    " Set the git grep string as the Vim search too
    let @/=a:args

    " Hilight search matches
    set hlsearch

    " Add flag that the quickfix window was opened from GitGrep
    let s:GitGrepWindowOpen = 1
endfunction


function s:GitGrepClose()
    " Close the quickfix window if it was opened using GitGrep
    if s:GitGrepWindowOpen
        cclose
        let s:GitGrepWindowOpen = 0
    endif
endfunction

" Close GitGrep quickfix window after leaving it
" au BufLeave * :call s:GitGrepClose()
" autocmd FileType qf nnoremap <buffer> <CR> <CR>:call s:GitGrepClose()<CR>
autocmd FileType qf nnoremap <buffer> <CR> <CR>:cclose<CR>

" git-grep the word under the cursor immediately
 noremap <Leader>g :normal yiw<cr>\|:call GitGrep(@")<cr>

" User interace bindings
command! -nargs=* -complete=file GitGrep call GitGrep(<q-args>)
command! -nargs=* -complete=file G call GitGrep(<q-args>)
