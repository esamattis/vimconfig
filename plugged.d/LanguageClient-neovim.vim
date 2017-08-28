

let g:LanguageClient_autoStart = 1


let g:LanguageClient_serverCommands = {
    \ 'javascript': ['./wrapper.sh'],
    \ 'typescript': ['./wrapper.sh'],
    \ }


command Thover call LanguageClient_textDocument_hover()<CR>
command Tdefinition call LanguageClient_textDocument_definition()<CR>
command Trename call LanguageClient_textDocument_rename()<CR>

set signcolumn=yes
