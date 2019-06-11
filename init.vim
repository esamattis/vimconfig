call plug#begin()

if has('nvim')
    " Works only with Neovim
    "Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    " Plug 'autozimu/LanguageClient-neovim', { 'do': ':UpdateRemotePlugins' }
    "Plug 'mhartington/nvim-typescript', {'do': './install.sh'}

    " Breaks normal vim paste
    Plug 'bfredl/nvim-miniyank'
endif

Plug 'tpope/vim-sensible', { 'on': 'OldVim' }
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'tpope/vim-surround'
Plug 'airblade/vim-gitgutter'
Plug 'mattn/gist-vim'
Plug 'mattn/webapi-vim' " required by gist-vim
Plug 'tpope/vim-fugitive'
Plug 'vim-scripts/Rename'
Plug 'jeetsukumaran/vim-buffersaurus'
Plug 'tomtom/tcomment_vim'
Plug 'w0rp/ale'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-repeat' " makes surround work with . (repeat)
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'simnalamburt/vim-mundo' " alt https://github.com/mbbill/undotree
Plug 'vim-airline/vim-airline'
Plug 'machakann/vim-highlightedyank'
Plug 'tpope/vim-sleuth'
Plug 'sbdchd/neoformat'
Plug 'joshglendenning/vim-caddyfile'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'ajmwagar/vim-deus'
Plug 'scrooloose/nerdtree'
Plug 'chr4/nginx.vim'
Plug 'lepture/vim-jinja'
call plug#end()

"" Leader mappings
let mapleader = ","

" Helper variable for cross platform and vim/neovim usage
if has("win32")
    let s:vim_home = $HOME . '/AppData/Local/nvim'
elseif has('nvim')
    let s:vim_home = $HOME . '/.config/nvim'
else
    let s:vim_home = $HOME . '/.vim'
endif


" Load plugin specific custom config
for plugin in keys(g:plugs)
    let s:plugin_config = s:vim_home . '/plugged.d/' . plugin . '.vim'
    if filereadable(s:plugin_config)
        execute 'source ' . s:plugin_config
    endif
endfor


" Use cool visual search&replace on neovim
if has("nvim")
    set inccommand=split
endif

" Exit Neovim terminal mode with esc
if has("nvim")
    tnoremap <Esc> <C-\><C-n>
endif


if has('nvim')
    " Legacy 'easy paste' helper
    map <C-i> :echo 'No need'<cr>
else
    " Enter paste mode with Ctrl+i
    map <C-i> :set paste<CR>i
endif

" Always disable paste mode when leaving insert mode
au InsertLeave * set nopaste

" Simple paste for the command mode
cnoremap <C-y> <C-r>"

set nomodeline

" Show trailing whitespace characters
set list
set listchars=tab:▸\ ,trail:·,extends:…,nbsp:␣

" Show soft wrapped lines as …
set showbreak=↳

" Cooler tab completion for vim commands
" http://stackoverflow.com/questions/526858/how-do-i-make-vim-do-normal-bash-like-tab-completion-for-file-names
set wildmode=longest,list

" Easier quotes
imap § '
imap ½ `
imap ° `

" Easier curly braces insertion
imap EE {
imap RR }

" Map escape key to jj -- much faster to exit insert mode
imap jj <esc>



" Write buffer (save)
noremap <Leader>w :w<CR>
imap ,w <esc>:w<CR>

" Automatically resize splits when the window is resized
au VimResized * exe "normal! \<c-w>="



"" Extend navigation keys

" First non whitespace character
map ö ^

" End of line
map ä $

" Begining of line
map Ö 0

" Last non space character
map Ä g_

" Same for visual mode
vmap ö ^
vmap ä $
vmap Ö 0
vmap Ä g_

" hide buffers instead of closing them
" Allows to change buffers with unsaved changes
set hidden

" The crossair cursor
set cursorline cursorcolumn

colorscheme molokai

" Do not toggle to netrw view
let g:netrw_altfile = 1

"" DISABLED using ctrlp plugin for this
" Toggle with last previous buffer
" nnoremap <leader>m :b#<cr>

" Select another file from the directory of the current one
nnoremap <leader>F :execute 'edit' expand("%:p:h")<cr>

noremap <Leader>w :w<CR>

" Close current buffer without closing split window
" http://stackoverflow.com/a/4468491/153718
noremap <Leader>d :bp\|bd #<CR>


" Close windows
noremap <Leader>q :q<CR>
vnoremap <Leader>q <esc>:q<CR>
inoremap <Leader>q <esc>:q<CR>


" Make Y behave like other capitals. Yank (copy) to end of line.
map Y y$

" Use mouse only in visual mode
set mouse=v

" Turn regexp magic off from search
nnoremap / /\V
vnoremap / /\V

" Make searches case-insensitive, unless they contain upper-case letters:
set ignorecase
set smartcase

" Hilight all words matching the one under the cursor
noremap <Space> *N

" Clear search hilights
noremap  <Leader><Space> :noh<cr>

" Search literal strings
nnoremap <Leader>S :execute '/\V' . escape(input('/'), '\\/')<CR>
" Search literallly what was last yanked
nnoremap <Leader>s :execute '/\V' . escape(@", '\\/')<CR>
" Start search from visual selection. The let thing is to restore what was
" previously yanked to the unnamed register
vnoremap <Space> "xy:execute '/\V' . escape(@x, '\\/')<CR>:let @" = @0<CR>

" Join lines from below too. See :help J
map K kJ

" Easily resize split windows with Ctrl+hjkl
nnoremap <C-j> <C-w>+
nnoremap <C-k> <C-w>-
nnoremap <C-h> <C-w><
nnoremap <C-l> <C-w>>

" Show unsaved changes
command ShowUnsaved w !diff -u % -

" strip all trailing whitespace in the current file
nnoremap <leader>W mz:%s/\s\+$//<cr>:let @/=''<cr>'z

"  to reselect the text that was just pasted so I can perform commands (like
"  indentation) on it
nnoremap <leader>v V`]

" Use Q for formatting the current paragraph (or selection).
" Forces 80 character lines.
vmap Q gq
nmap Q gqap

" Move by screen lines instead of file line. Nice with long lines.
nnoremap j gj
nnoremap k gk

" Reset messed up Vim. Redraw screen, clear search hilights and balance window
" splits
map <F5> :redraw! \| :noh \| <cr><c-w>=

" Reselect visual block after indent/outdent. Allow ident/outdent multiple
" times
vnoremap < <gv
vnoremap > >gv


" Some aliases for typoists
command W w
command Q q
command WQ wq
command Wq wq
command Qa qa
command QA qa
command Wa wa
command WA wa
command E e
nnoremap ; :
vnoremap ; :
nnoremap _ :
vnoremap _ :

" and abbreviations
abbreviate lenght length
abbreviate lenghts lengths
abbreviate heigth height

" Open git diff window when editing a commit message
autocmd FileType gitcommit DiffGitCached | wincmd p

" allow the repeat command (.) to execute once for each line of a visual selection
vnoremap . :normal .<CR>

" Allow visual block selection go beyond end of lines
set virtualedit=block

" Vim’s defaults are awful messy, leaving .swp files everywhere if the editor
" isn’t closed properly. This can save you a lot of time.
set nobackup
set noswapfile

" Autosave only when there is something to save. Always saving makes build
" watchers crazy
function! SaveIfUnsaved()
    if &modified
        :silent! w
    endif
endfunction
au FocusLost,BufLeave * :call SaveIfUnsaved()
" Read the file on focus/buffer enter
au FocusGained,BufEnter * :silent! !


" Assume json file type for these files
augroup json
    au!
    au BufNewFile,BufRead .eslintrc,.babelrc,.prettierrc setlocal filetype=json
augroup END


" Treat dash as part of words. Really nice for CSS.
set iskeyword+=-

" Change tab behaviour
command -nargs=1 TabSpace setlocal expandtab shiftwidth=<args> tabstop=<args> softtabstop=<args>
command -nargs=1 Tab setlocal noexpandtab shiftwidth=<args> tabstop=<args> softtabstop=<args>

" Convert foo-bar to fooBar
command ToCamel normal f-xvgU

" Close other window splits
command O only
map <Leader>o :only<cr>



" Load new .prettierc files with personal defaults
autocmd BufNewFile .prettierrc setfiletype json | read $HOME/.config/nvim/defaults/.prettierrc

autocmd BufNewFile local.vim setfiletype vim | read $HOME/.config/nvim/defaults/local.vim

" Local vim config customization not tracked by this git
if filereadable(s:vim_home . "/local.vim")
    execute 'source ' . s:vim_home . "/local.vim"
endif

" TODO: move to plugin specific config file
let g:ale_linters = {'javascript': ['eslint']}
