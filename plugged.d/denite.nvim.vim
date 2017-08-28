

call denite#custom#alias('source', 'file_rec/git', 'file_rec')
call denite#custom#var('file_rec/git', 'command',
    \ ['git', 'ls-files', '-co', '--exclude-standard'])

call denite#custom#alias('source', 'file_rec/basic', 'file_rec')
call denite#custom#var('file_rec/basic', 'command',
    \ ['ls', '-1'])

nnoremap <leader>t :Denite file_rec/git<CR>
nnoremap <leader>f :DeniteBufferDir file_rec/basic<CR>
nnoremap <leader>m :Denite buffer<CR>
