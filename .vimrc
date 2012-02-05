"http://sontek.net/turning-vim-into-a-modern-python-ide"
filetype off
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

set showmode              " show what mode we're in
set number                " turn on line numbers
set foldmethod=indent     " 
set foldlevel=99          " limit how many folds w/in folds you can have
set nocompatible          " forget about being vi compatible
set background=dark       " make default colors dark-background compatible 
set autoindent            " add auto-indentation
set copyindent            " copy the prev indentation on autoindentingi
set smartcase             " ignore case when patterns is a lowercase
set tabstop=4             " 
set softtabstop=4         " 
set shiftwidth=4          " 
set expandtab             " 
set scrolloff=4           " keep 4 lines off edges of screen
set backspace=2           " allow backspacing over indent, eol, etc
set ruler                 " show cursor position at all times
set autoread              " auto read when file changes
set hlsearch              " search highlighting
set incsearch             " show search matches as you type them
set clipboard^=unnamed    " yank to systems register (*) by default
set showmatch             " show matching parenthesis when hovering 
set history=1000          " remember all the stupid things I do 
set undolevels=1000       " give me lots of room to undo my stupid mistakes
set visualbell            " quit your yapping
set noerrorbells          " quit your damn yapping
set wildmenu              " make tab completion for files act like bash
set wildmode=list:longest,full " COMMAND TAB completion from list-full
set wildignore=*.swp,*.bak,*.pyc,*.class
set title                 " change the terminals title
set pastetoggle=<F2>      " lets you paste stuff from outside terminal
set virtualedit=all       " allow the cursor to go into 'invalid' places
set showfulltag           " when completing by tag, show whole tag
set gdefault              " set /g flag on :s substitutions by default


" Setup the mouse to work within vim terminal
set mouse=a               " Enable the mouse
set ttymouse=xterm2       " Set mouse for mac?
behave xterm
set selectmode=mouse 

" prevent startup error messages from disappearing after one second
" set debug=msg

" this hides buffers instead of closing them. AKA you can have
" unwritten changes to a file and still open a new file using :e
" without being forced to write or undo your changes first.
set hidden


if has('statusline')
    set laststatus=2
    
    " Broken down into easily includeable segments
    set stl=%<%f\                          " Filename
    set stl+=%w\ %h\ %m\ %r                " Options
    set stl+=%{fugitive#statusline()}      " Git Hotness
    set stl+=\ [%{&ff}/%Y]                 " filetype
    set stl+=\ [%{getcwd()}]               " current dir
    set stl+=\ %=Line:%l/%L                " line number / total lines
    set stl+=\ Col:%v                      " Column number
    set stl+=\ [Buf:#%n]                   " Current buffer number
    set stl+=\ %p%%                        " Document position by %
    set stl+=\ [ASCII=\%03.3b/HEX=\%02.2B] " ASCII / Hexadecimal value of char
endif

" set status line the way Derek Wyatt likes it
" set stl=%f\ %m\ %r%{fugitive#statusline()}\ Line:%l/%L[%p%%]\ Col:%v\ Buf:#%n\ [%b][0x%B]

" set gui cursor to look nice
set guicursor=n-v-c:block-Cursor-blinkon0,ve:ver35-Cursor,o:hor50-Cursor,i-ci:ver25-Cursor,r-cr:hor20-Cursor,sm:block-Cursor-blinkwait175-blinkoff150-blinkon175

" Remove trailing whitespace and ^M characters from some filetypes
autocmd FileType c,cpp,java,php,js,python,twig,xml,yml autocmd BufWritePre <buffer> :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))

" Show highlighting groups for current word so that you
" can identify where an element is getting its color from
" Shortcut is: CTRL + SHIFT + p
nmap <C-S-P> :call <SID>SynStack()<CR>
function! <SID>SynStack()
    if !exists("*synstack")
        return
    endif
    echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

" add shortcut to quickly edit the vimrc file
nmap <silent> ,ev :e $MYVIMRC<CR>
nmap <silent> ,sv :so $MYVIMRC<CR>

" Press space bar to turn off higlighting after a search
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

" auto reload vimrc while editing it
autocmd! bufwritepost .vimrc source ~/.vimrc

filetype plugin on
filetype on                  " try to detect filetypes
filetype plugin indent on    " enable loading indent file for filetype
filetype indent on

let &t_Co=256                " set terminal to accept 256 colors
let python_highlight_all = 1

" Highlighting {{{
if &t_Co >= 256 || has("gui_running")
   colorscheme molokai
endif

if &t_Co > 2 || has("gui_running")
   syntax on " turn syntax highlighting on             
endif
" }}}

  
" set your map leader to comma instead \
let mapleader=","

" Underline the current line with '='
nmap <silent> ,ul :t.\|s/./=/g\|:nohls<cr>

" Shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>

" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬,trail:.,extends:#,nbsp:.

" remap your up and down navigation keys to respect line wrapping
nnoremap j gj
nnoremap k gk

" use Q to auto-format the current selected paragraph
vmap Q gq
nmap Q gqap

" Press F2 to toggle line #'s  and fold columns for easy copying
" nnoremap <F2> :set nonumber!<CR>:set foldcolumn=0<CR>

" map new keys for window splits
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

" remap some keys for Task lists
map <leader>td <Plug>TaskList

" remap keys for revision history using Gundo plugin
map <leader>g :GundoToggle<CR>

" map shortcut key for opening the NERD Tree file browser
map <leader>n :NERDTreeToggle<CR>

" Store NERDTree bookmarks file
let NERDTreeBookmarksFile=expand("$HOME/.vim/NERDTreeBookmarks")
let NERDTreeShowBookmarks=1       " Show the bookmarks table on startup
let NERDTreeShowFiles=1           " Show hidden files, too
let NERDTreeShowHidden=1
let NERDTreeQuitOnOpen=1          " Quit on opening files from the tree
let NERDTreeHighlightCursorline=1 " Highlight the selected entry in the tree
let NERDTreeMouseMode=2           " Single click to open directories, double click to open files

" ignore certain filetypes
let NERDTreeIgnore=[ '\.pyc$', '\.pyo$', '\.py\$class$', '\.obj$',
            \ '\.o$', '\.so$', '\.egg$', '^\.git$' ]


" map refactoring and go to definition for Ropevim plugin
map <leader>j :RopeGotoDefininition<CR>
map <leader>r :RopeRename<CR>

" map the ACK search key
nmap <leader>ack <Esc>:Ack!

" map execution of tests using py.test
nmap <silent><Leader>tf <Esc>:Pytest file<CR>
nmap <silent><Leader>tc <Esc>:Pytest class<CR>
nmap <silent><Leader>tm <Esc>:Pytest method<CR>

" cycle through test errors
nmap <silent><Leader>tn <Esc>:Pytest next<CR>
nmap <silent><Leader>tp <Esc>:Pytest previous<CR>
nmap <silent><Leader>te <Esc>:Pytest error<CR>

" type jj to quickly exit out of insert mode
inoremap jj <Esc>

" tell pyflakes not to use the quickfix window "
let g:pyflakes_use_quickfix = 0

" add key mapping to jump to each of the pep8 violtions in the quickfix window "
let g:pep8_map='<leader>8'

" configure SuperTab to be context sensitive and to enable omni code completion "
au FileType python set omnifunc=pythoncomplete#Complete
let g:SuperTabDefaultCompletionType = "context"

" enable pydoc preview to get the most useful info out of the code completion "
set completeopt=menuone,longest,preview

" Quick alignment of text
nmap <leader>al :left<CR>
nmap <leader>ar :right<CR>
nmap <leader>ac :center<CR>


"--------------------------------------------------------------------------- 
" Add syntax highlighting to JSON files
autocmd BufNewFile,BufRead *.json set ft=javascript



"--------------------------------------------------------------------------- 
" TABULARIZE
"--------------------------------------------------------------------------- 

if exists(":Tabularize")
    nmap <Leader>a= :Tabularize /=<CR>
    vmap <Leader>a= :Tabularize /=<CR>
    nmap <Leader>a: :Tabularize /:<CR>
    vmap <Leader>a: :Tabularize /:<CR>
    nmap <Leader>a:: :Tabularize /:\zs<CR>
    vmap <Leader>a:: :Tabularize /:\zs<CR>
    nmap <Leader>a, :Tabularize /,<CR>
    vmap <Leader>a, :Tabularize /,<CR>
    nmap <Leader>a<Bar> :Tabularize /<Bar><CR>
    vmap <Leader>a<Bar> :Tabularize /<Bar><CR>
endif

"if exists(":Tabularize")
"    inoremap <Leader>a= :Tabularize /=<CR>
"    vmap <Leader>a= :Tabularize /=<CR>
"    nmap <Leader>a=1 :Tabularize /^\(.\{-}\zs=\)\{1}<CR>
"    inoremap <Leader>a: :Tabularize /:\zs<CR>
"    vmap <Leader>a: :Tabularize /:\zs<CR>
"endif

" Lets map some greek letters and other chars for use in mathematical equations
" LOGIC
inoremap <leader>forall ∀
inoremap <leader>exists ∃
inoremap <leader>not ¬
inoremap <leader>implies ⇒
inoremap <leader>equivalent ⇔
inoremap <leader>and ∧
inoremap <leader>or ∨


"--------------------------------------------------------------------------- 
"" ENCODING SETTINGS
"--------------------------------------------------------------------------- 
set encoding=utf-8                                  
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,big5,gb2312,latin1

fun! ViewUTF8()
    set encoding=utff-8                                  
    set termencoding=big5
endfun

fun! UTF8()
    set encoding=utf-8                                  
    set termencodingrmencoding=big5
    set fileencoding=utf-8
    set fileencodings=ucs-bom,big5,utf-8,latin1
endfun

fun! Big5()
    set encoding=big5
    set fileencoding=fileencodingbig5
endfun



"--------------------------------------------------------------------------- 

"---------------------------------------------------------------------------
" tips taken from
" https://github.com/nvie/vimrc/blob/master/vimrc


" Conflict markers {{{
" highlight conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" shortcut to jump to next conflict marker
nmap <silent> <leader>c /^\(<\\|=\\|>\)\{7\}\([^=].\+\)\?$<CR>
" }}}

" Filetype specific handling {{{
" only do this part when compiled with support for autocommands
if has("autocmd")

    augroup vim_files "{{{
        au!

        " Bind <F1> to show the keyword under cursor
        " general help can still be entered manually, with :h
        autocmd filetype vim noremap <buffer> <F1> <Esc>:help <C-r><C-w><CR>
        autocmd filetype vim noremap! <buffer> <F1> <Esc>:help <C-r><C-w><CR>
    augroup end "}}}

    augroup html_files "{{{
        au!

        " This function detects, based on HTML content, whether this is a
        " Django template, or a plain HTML file, and sets filetype accordingly
        fun! s:DetectHTMLVariant()
            let n = 1
            while n < 50 && n < line("$")
                " check for django
                if getline(n) =~ '{%\s*\(extends\|load\|block\|if\|for\|include\|trans\)\>'
                    set ft=htmldjango.html
                    return
                endif
                let n = n + 1
            endwhile
            " go with html
            set ft=html
        endfun

        autocmd BufNewFile,BufRead *.html,*.htm call s:DetectHTMLVariant()

        " Auto-closing of HTML/XML tags
        let g:closetag_default_xml=1
        autocmd filetype html,htmldjango let b:closetag_html_style=1
        autocmd filetype html,xhtml,xml source ~/.vim/scripts/closetag.vim
    augroup end " }}}

    augroup python_files "{{{
        au!

        " This function detects, based on Python content, whether this is a
        " Django file, which may enabling snippet completion for it
        fun! s:DetectPythonVariant()
            let n = 1
            while n < 50 && n < line("$")
                " check for django
                if getline(n) =~ 'import\s\+\<django\>' || getline(n) =~ 'from\s\+\<django\>\s\+import'
                    set ft=python.django
                    "set syntax=python
                    return
                endif
                let n = n + 1
            endwhile
            " go with html
            set ft=python
        endfun
        autocmd BufNewFile,BufRead *.py call s:DetectPythonVariant()

        " PEP8 compliance (set 1 tab = 4 chars explicitly, even if set
        " earlier, as it is important)
        autocmd filetype python setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4
        autocmd filetype python setlocal textwidth=80
        " make any characters in columns 80+ highlight as an error
        autocmd filetype python match ErrorMsg '\%>80v.\+'

        " But disable autowrapping as it is super annoying
        autocmd filetype python setlocal formatoptions-=t

        " Folding for Python (uses syntax/python.vim for fold definitions)
        "autocmd filetype python,rst setlocal nofoldenable
        "autocmd filetype python setlocal foldmethod=expr

        " Python runners
        autocmd filetype python map <buffer> <F5> :w<CR>:!python %<CR>
        autocmd filetype python imap <buffer> <F5> <Esc>:w<CR>:!python %<CR>
        autocmd filetype python map <buffer> <S-F5> :w<CR>:!ipython %<CR>
        autocmd filetype python imap <buffer> <S-F5> <Esc>:w<CR>:!ipython %<CR>

        " Run a quick static syntax check every time we save a Python file
        " autocmd BufWritePost *.py call Pyflakes()
    augroup end " }}}

    augroup ruby_files "{{{
        au!

        autocmd filetype ruby setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
    augroup end " }}}

    augroup rst_files "{{{
        au!

        " Auto-wrap text around 74 chars
        autocmd filetype rst setlocal textwidth=74
        autocmd filetype rst setlocal formatoptions+=nqt
        autocmd filetype rst match ErrorMsg '\%>74v.\+'
    augroup end " }}}

    augroup css_files "{{{
        au!

        autocmd filetype css,less setlocal foldmethod=marker foldmarker={,}
    augroup end "}}}

    augroup javascript_files "{{{
        au!

        autocmd filetype javascript setlocal expandtab
        autocmd filetype javascript setlocal listchars=trail:·,extends:#,nbsp:·
        autocmd filetype javascript setlocal foldmethod=marker foldmarker={,}
    augroup end "}}}

    augroup textile_files "{{{
        au!

        autocmd filetype textile set tw=78 wrap

        " Render YAML front matter inside Textile documents as comments
        autocmd filetype textile syntax region frontmatter start=/\%^---$/ end=/^---$/
        autocmd filetype textile highlight link frontmatter Comment
    augroup end "}}}
endif
" }}}


" Restore cursor position upon reopening files {{{
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
" }}}

" Common abbreviations / misspellings {{{
source ~/.vim/autocorrect.vim
" }}}

