" settings.
set autowrite
set background=dark
set nobackup
set cindent
set cinoptions=:0
set fileencodings=utf-8,gb2312,gbk,gb18030
set fileformat=unix
set foldenable
set foldmethod=indent
set foldlevel=128
set helpheight=10
set helplang=cn
set hidden
set signcolumn=yes
set ignorecase
set mouse=nvic
set number
set pumheight=10
set ruler
set scrolloff=2
set showcmd
set smartindent
set smartcase
" expand 1 tab to 4 spaces
set expandtab
set tabstop=4
set shiftwidth=4

set noswapfile

" share system clipboard
set clipboard=unnamedplus " When possible use + register for copy-paste

"cursor line
set linespace=2
set cursorline

set termencoding=utf-8
set textwidth=80
set wrap
set whichwrap=<,>,[,]
set completeopt-=preview
set noshowmode
" global ignore
set wildignore=
"common
set wildignore+=*/.svn,*/.git,*/.hg
set wildignore+=tags,.vim_tags
set wildignore+=.tags
set wildignore+=*.swp
" tmp dir
set wildignore+=*/_cache,*/.cache
set wildignore+=*/_tmp,*/.tmp
" build dir
" set wildignore+=*/_release/*,*/.release/*
" set wildignore+=*/build/*,*/build-*/*
set wildignore+=*/_repo
" c/cpp
set wildignore+=*/*.so,*/*.o,*/*.obj,*/*.class
" py
set wildignore+=*/*.pyc,*/*.pyo,*/__pycache__

set wildmode=list:longest,full
set wrap
set t_Co=256

" open file at last postion
autocmd BufReadPost *
            \ if line("'\"") > 1 && line("'\"") <= line("$") |
            \   exe "normal! g`\"" |
            \ endif

if has('persistent_undo')      "check if your vim version supports it
    if !isdirectory(glob('~/.vim/undo'))
        exe "!mkdir ~/.vim/undo"
    endif
    set undofile                 "turn on the feature
    set undodir=$HOME/.vim/undo  "directory where the undo files will be stored
endif

" SHORTCUT SETTINGS:
" Set mapleader
let mapleader=" "

" Switching between buffers.
" switch to normal
inoremap jk <Esc>

" terminal, copy from SPCVim
let g:pos = 'bottom'
let g:height = 30
let s:shell_win_nr = 0
function OpenShell()
    if s:shell_win_nr != 0 && getwinvar(s:shell_win_nr, '&buftype') ==# 'terminal' && &buftype !=# 'terminal'
        exe s:shell_win_nr .  'wincmd w'
        startinsert
        return
    endif

    let cmd = g:pos ==# 'top' ?
                \ 'topleft split' :
                \ g:pos ==# 'bottom' ?
                \ 'botright split' :
                \ g:pos ==# 'right' ?
                \ 'rightbelow vsplit' : 'leftabove vsplit'
    exe cmd
    let lines = &lines * g:height / 100
    if lines < winheight(0) && (g:pos ==# 'top' || g:pos ==# 'bottom')
        exe 'resize ' . lines
    endif
    if exists(':terminal')
        exe 'terminal'
        let s:shell_win_nr = winnr()
        setlocal nobuflisted
        startinsert
    else
        echo ':terminal is not supported in this version'
    endif
endfunction
nnoremap <silent><Leader>; :call OpenShell()<cr>
tnoremap <Esc> <C-\><C-n>

" window-resize
nmap w= :res +5<CR>
nmap w- :res -5<CR>
nmap w, :vertical res +10<CR>
nmap w. :vertical res -10<CR>

" clear  ^M at the end of line in normal mode
nmap cM :%s/\r$//g<CR>:noh<CR>

" delete SPACE at the end of line
nmap cm :%s/\s\+$//<CR>:noh<CR>
