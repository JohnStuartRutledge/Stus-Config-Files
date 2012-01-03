"http://sontek.net/turning-vim-into-a-modern-python-ide"
filetype off
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()


set number                " turn on line numbers
set foldmethod=indent
set foldlevel=99
set nocompatible          " forget about being vi compatible
set background=dark
set autoindent
set tabstop=4
set softtabstop=4
set expandtab
set shiftwidth=4
set ruler

let &t_Co=256             " set terminal to accept 256 colors
colorscheme molokai       " set your color scheme
syntax on                 " syntax highlighting
filetype on               " try to detect filetypes
filetype plugin indent on " enable loading indent file for filetype
filetype indent on

" Shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>

" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬

" Press F2 to toggle line #'s  and fold columns for easy copying
nnoremap <F2> :set nonumber!<CR>:set foldcolumn=0<CR>

" map new keys for window splits
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

" remap some keys for Tak lists
map <leader>td <Plug>TaskList

" remap keys for revision history using Gundo plugin
map <leader>g :GundoToggle<CR>

" map shortcut key for opening the NERD Tree file browser
map <leader>n :NERDTreeToggle<CR>

" map refactoring and go to definition for Ropevim plugin
map <leader>j :RopeGotoDefininition<CR>
map <leader>r :RopeRename<CR>

" map the ACK search key
nmap <leader>a <Esc>:Ack!

" map execution of tests using py.test
nmap <silent><Leader>tf <Esc>:Pytest file<CR>
nmap <silent><Leader>tc <Esc>:Pytest class<CR>
nmap <silent><Leader>tm <Esc>:Pytest method<CR>
" cycle through test errors
nmap <silent><Leader>tn <Esc>:Pytest next<CR>
nmap <silent><Leader>tp <Esc>:Pytest previous<CR>
nmap <silent><Leader>te <Esc>:Pytest error<CR>


" tell pyflakes not to use the quickfix window "
let g:pyflakes_use_quickfix = 0

" add key mapping to jump to each of the pep8 violtions in the quickfix window "
let g:pep8_map='<leader>8'

" configure SuperTab to be context sensitive and to enable omni code completion "
au FileType python set omnifunc=pythoncomplete#Complete
let g:SuperTabDefaultCompletionType = "context"

" enable pydoc preview to get the most useful info out of the code completion "
set completeopt=menuone,longest,preview


set statusline=%{fugitive#statusline()}



