""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"   init.vim - Configuration file for neovim.
"
"   Created : 2017-01-21
"   Author  : Tommy Yang
"   Email   : yangyinqi1991@gmail.com
"   Description :
"       This config for nvim is mainly designed for C/C++/Python program coding,
"       and also for java,js,markdown,html.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

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
set ignorecase
set mouse=v
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
set wildignore+=*/.svn/*,*/.git/*,*/.hg/*
set wildignore+=tags,.vim_tags
set wildignore+=.tags
set wildignore+=*.swp
" tmp dir
set wildignore+=*/_cache/*,*/.cache/*
set wildignore+=*/_tmp/*,*/.tmp/*
" build dir
" set wildignore+=*/_release/*,*/.release/*
" set wildignore+=*/build/*,*/build-*/*
set wildignore+=*/_repo/*
" c/cpp
set wildignore+=*/.so/*,*/.o/*,*/.obj/*,*/.class/*
" py
set wildignore+=*/.pyc/*,*/.pyo/*

set wildmode=list:longest,full
set wrap
set t_Co=256

if has('unix')
    if !has('mac')
        let g:clang_path = '/usr/lib/llvm-6.0/lib/libclang.so'
        let g:clang_header = '/usr/lib/clang/6.0'
    else
        let g:clang_path = '/Library/Developer/CommandLineTools/usr/lib/libclang.dylib'
        let g:clang_header = '/Library/Developer/CommandLineTools/usr/lib/clang'
    endif
endif

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
let mapleader="'"

" Space to command mode.
nnoremap <space> :
vnoremap <space> :

" Switching between buffers.
" switch to normal
inoremap jk <Esc>

" start vim-plug
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
    silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Specify a directory for plugins
call plug#begin('~/.vim/plugged')

" core
Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
Plug 'tyru/open-browser.vim', {'on': ['OpenBrowserSmartSearch', 'OpenBrowser', 'OpenBrowserSearch']}
Plug 'jsfaint/gen_tags.vim'
Plug 'wsdjeg/FlyGrep.vim'
Plug 'tenfyzhong/CompleteParameter.vim'

" utils
Plug 'junegunn/vim-easy-align'
Plug 'Lokaltog/vim-easymotion'
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-signify'
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'tpope/vim-surround'
Plug 'mbbill/undotree'
Plug 'tpope/vim-unimpaired'
Plug 'haya14busa/incsearch.vim'
Plug 'haya14busa/incsearch-fuzzy.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'skywind3000/asyncrun.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'Shougo/echodoc.vim'

" code completion
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

" markdown
Plug 'joker1007/vim-markdown-quote-syntax', {'for': 'markdown'}
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'iamcco/mathjax-support-for-mkdp', {'for': 'markdown'}
Plug 'iamcco/markdown-preview.vim', {'for': 'markdown'}
Plug 'mzlogin/vim-markdown-toc', {'for': 'markdown'}
Plug 'lvht/tagbar-markdown'

" viml
Plug 'Shougo/neco-vim'

" UI
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeTabsToggle' }
Plug 'Xuyuanp/nerdtree-git-plugin', { 'on': 'NERDTreeTabsToggle' }
Plug 'jistr/vim-nerdtree-tabs', { 'on': 'NERDTreeTabsToggle' }
Plug 'Yggdroot/indentLine'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'majutsushi/tagbar',{ 'on': 'TagbarToggle' }
Plug 'tenfyzhong/tagbar-makefile.vim'
Plug 't9md/vim-choosewin'
Plug 'joshdick/onedark.vim'
Plug 'mhinz/vim-startify'
Plug 'ryanoasis/vim-devicons' " file icons

call plug#end()
" setup end

" PLUGIN SETTINGS
colorscheme onedark

" fly grep
nnoremap fg :FlyGrep<CR>

" echodoc
let g:echodoc#enable_at_startup = 1

" tags
let $GTAGSLABEL = 'native-pygments'
let $GTAGSLIBPATH='/usr/include/'
let g:gen_tags#gtags_auto_gen = 1
let g:loaded_gentags#gtags = 0
let g:loaded_gentags#ctags = 1  " disable ctags support, use gtags only
let g:gen_tags#ctags_auto_gen = 0
let g:gen_tags#blacklist = split(glob('~/.vim/plugged/*'))
let g:gen_tags#blacklist += split(glob('~/.vim/*'))

" let g:gen_tags#verbose = 1
nmap <leader>gg :GenGTAGS<cr>
nmap <leader>gc :ClearGTAGS!<cr>
""" short cuts:
"  Ctrl+\ c    Find functions calling this function
"  Ctrl+\ d    Find functions called by this function
"  Ctrl+\ e    Find this egrep pattern
"  Ctrl+\ f    Find this file
"  Ctrl+\ g    Find this definition
"  Ctrl+\ i    Find files #including this file
"  Ctrl+\ s    Find this C symbol
"  Ctrl+\ t    Find this text string
"""

" code completion
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_ignore_case = 1
let g:deoplete#enable_smart_case = 1
let g:deoplete#enable_camel_case = 1
let g:deoplete#enable_refresh_always = 1
let g:deoplete#max_abbr_width = 0
let g:deoplete#max_menu_width = 0
" autocmd CompleteDone * silent! pclose!
let g:LanguageClient_serverCommands = {
    \ 'python': ['~/Library/Python/3.7/bin/pyls'],
    \ 'c': ['ccls'],
    \ 'cpp': ['ccls'],
    \ }
let g:LanguageClient_selectionUI = 'quickfix'

nnoremap <silent> Km :call LanguageClient_contextMenu()<CR>
" Or map each action separately
nnoremap <silent> Kd :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
" nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>


" <python>
augroup lang_python
    au!
    autocmd FileType python nnoremap <F7> :AsyncRun -raw python3 %<CR>
augroup END

" asyncrun
let g:asyncrun_open = 6
let g:asyncrun_bell = 1
nnoremap <silent> <F8> :call asyncrun#quickfix_toggle(6)<CR>
let g:asyncrun_rootmarks = ['.svn', '.git', '.root'] 

" markdown
" let g:vim_markdown_autowrite = 1
let g:vim_markdown_folding_disabled = 1
set conceallevel=0
let g:vim_markdown_conceal = 0
let g:vim_markdown_frontmatter=1

" auto paris cfg, copy from zf_vimrc
let g:AutoPairsShortcurToggle=''
let g:AutoPairsShortcutFastWrap=''
let g:AutoPairsShortcutJump=''
let g:AutoPairsShortcutBackInsert=''
let g:AutoPairsCenterLine=0
let g:AutoPairsMultilineClose=0
let g:AutoPairsMapBS=1
let g:AutoPairsMapCh=0
let g:AutoPairsMapCR=0
let g:AutoPairsCenterLine=0
let g:AutoPairsMapSpace=0
let g:AutoPairsFlyMode=0
let g:AutoPairsMultilineClose=0
let g:AutoPairs = {'[':']', '{':'}',"'":"'",'"':'"', '`':'`', '(':')'}
inoremap <buffer><silent> ) <C-R>=AutoPairsInsert(')')<CR>

" leaderf config
let g:Lf_CursorBlink = 1
let g:Lf_StlSeparator = { 'left': '', 'right': '' }
let g:Lf_RootMarkers = ['.project', '.root', '.svn', '.git', '.hg']
let g:Lf_WorkingDirectoryMode = 'Ac'
let g:Lf_WindowHeight = 0.30
let g:Lf_CacheDirectory = expand('~/.vim/cache/leaderf')
let g:Lf_ShowRelativePath = 0
let g:Lf_HideHelp = 1
let g:Lf_StlColorscheme = 'onedark'
let g:Lf_PreviewResult = {'Function':0}
let g:Lf_NormalMap = {
            \ "File":   [["<ESC>", ':exec g:Lf_py "fileExplManager.quit()"<CR>']],
            \ "Buffer": [["<ESC>", ':exec g:Lf_py "bufExplManager.quit()"<CR>']],
            \ "Mru":    [["<ESC>", ':exec g:Lf_py "mruExplManager.quit()"<CR>']],
            \ "Tag":    [["<ESC>", ':exec g:Lf_py "tagExplManager.quit()"<CR>']],
            \ "BufTag":    [["<ESC>", ':exec g:Lf_py "buftagExplManager.quit()"<CR>']],
            \ "Function":    [["<ESC>", ':exec g:Lf_py "functionExplManager.quit()"<CR>']],
            \ "Colorscheme":    [["<ESC>", ':exec g:Lf_py "colorschemeExplManager.quit()"<CR>']],
            \ }
let g:Lf_WildIgnore = {
            \ 'dir': ['.svn','.git','.hg'],
            \ 'file': ['*.sw?','~$*','*.bak','*.exe','*.o','*.so','*.py[co]']
            \}
noremap <leader>m :LeaderfMru<cr>
" noremap <leader>f :LeaderfFile<cr>
noremap <leader>c :LeaderfFunction!<cr>
noremap <leader>v :LeaderfBufTag!<cr>
" noremap <leader>b :LeaderfBuffer<cr>
" noremap <leader>t :LeaderfTag<cr>
noremap <leader>o :LeaderfColorscheme<cr>

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
nnoremap <silent><space>; :call OpenShell()<cr>
tnoremap <Esc> <C-\><C-n>

" vim-easy-align
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" CompleteParameter
function! Plugin_CompleteParameter_tab(forward)
    if pumvisible()
        return a:forward ? "\<c-n>" : "\<c-p>"
    endif
    if cmp#jumpable(a:forward)
        if a:forward
            return "\<Plug>(complete_parameter#goto_next_parameter)"
        else
            return "\<Plug>(complete_parameter#goto_previous_parameter)"
        endif
    endif
    if a:forward
        let line = getline('.')
        let col = col('.')
        if col <= 1 || len(line) < col - 2 || line[col - 2] == ' ' || line[col - 2] == "\<c-x>"
            return "\<c-x>"
        endif
        return "\<c-x>\<c-u>"
    endif
    return ''
endfunction
function! Plugin_CompleteParameter_setting()
    map <c-x> <Plug>(complete_parameter#goto_next_parameter)
    imap <silent><expr> <c-x> '' . Plugin_CompleteParameter_tab(1)
endfunction
augroup Plugin_CompleteParameter_augroup
    autocmd!
    autocmd FileType * call Plugin_CompleteParameter_setting()
augroup END
let g:complete_parameter_use_ultisnips_mapping = 1

" alrLine Config
let g:airline_theme='onedark'
let g:airline_powerline_fonts = 1
let g:airline_skip_empty_sections = 1
" tabline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_splits = 1
" let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#show_tab_nr = 1
let g:airline#extensions#tabline#buffer_nr_show = 0
let g:airline#extensions#tabline#tab_nr_type = 2 " splits and tab number
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#tabline#buffer_nr_format = '%s:'
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#fnamecollapse = 2
let g:airline#extensions#tabline#fnametruncate = 16
let g:airline#extensions#tabline#formatter = 'default'
" buffer select
noremap <silent><leader>d :bp<bar>sp<bar>bn<bar>bd!<CR>
nmap <silent><leader>1 <Plug>AirlineSelectTab1
nmap <silent><leader>2 <Plug>AirlineSelectTab2
nmap <silent><leader>3 <Plug>AirlineSelectTab3
nmap <silent><leader>4 <Plug>AirlineSelectTab4
nmap <silent><leader>5 <Plug>AirlineSelectTab5
nmap <silent><leader>6 <Plug>AirlineSelectTab6
nmap <silent><leader>7 <Plug>AirlineSelectTab7
nmap <silent><leader>8 <Plug>AirlineSelectTab8
nmap <silent><leader>9 <Plug>AirlineSelectTab9
" ale
let g:airline#extensions#ale#enabled = 1
let airline#extensions#ale#error_symbol = 'E:'
let airline#extensions#ale#warning_symbol = 'W:'
let airline#extensions#ale#show_line_numbers = 1
let airline#extensions#ale#open_lnum_symbol = '(L'
let airline#extensions#ale#close_lnum_symbol = ')'
" virtualenv for python
let g:airline#extensions#virtualenv#enabled = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline#extensions#tabline#buffer_idx_format = {
            \ '0': '0 ',
            \ '1': '1 ',
            \ '2': '2 ',
            \ '3': '3 ',
            \ '4': '4 ',
            \ '5': '5 ',
            \ '6': '6 ',
            \ '7': '7 ',
            \ '8': '8 ',
            \ '9': '9 '
            \}
" tabline symbol
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#right_sep = ''
" powerline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.redonly = ''
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.maxlinenr = ''
" tagbar integration
let g:airline#extensions#tagbar#enabled = 1
let g:airline#extensions#tagbar#flags = ''
let g:airline#extensions#tagbar#flags = 'f'
let g:airline#extensions#tagbar#flags = 's'
let g:airline#extensions#tagbar#flags = 'p'

" nerdtree relations
let g:NERDTreeShowLineNumbers=1                
let g:NERDTreeWinPos="left"                    
let g:NERDTreeWinSize=30                       
let g:NERDTreeMinimalUI=1                      
let g:NERDTreeDirArrows=1   "dir arrow: 1-arrow  0-'+-|'
let g:NERDTreeAutoCenter=1                     
let NERDTreeShowHidden=1                       
let NERDTreeIgnore=['\.pyc','\~$','\.swp', '\.svn', '\.git']
let NERDTreeRespectWildIgnore = 1
let NERDTreeShowBookmarks=1

"  vim-nerdtree-tabs.vim
let g:nerdtree_tabs_open_on_console_startup=1
" always focus file window after startup
let g:nerdtree_tabs_smart_startup_focus=2   
let g:nerdtree_tabs_autoclose = 1           
"let g:nerdtree_tabs_focus_on_files=1       
"let g:nerdtree_tabs_autofind=1             
nnoremap <silent><F2> :NERDTreeTabsToggle<cr>

" nerdtree-git-plugin.vim                   
let g:NERDTreeShowGitStatus = 0
let g:NERDTreeIndicatorMapCustom = {
            \ "Modified"  : "✹",
            \ "Staged"    : "✚",
            \ "Untracked" : "✭",
            \ "Renamed"   : "➜",
            \ "Unmerged"  : "═",
            \ "Deleted"   : "✖",
            \ "Dirty"     : "✗",
            \ "Clean"     : "✔︎",
            \ "Unknown"   : "?"
            \ }

" choosewin
" invoke with '-'
nmap  -  <Plug>(choosewin)
" use overlay feature
let g:choosewin_overlay_enable = 1
" workaround for the overlay font being broken on mutibyte buffer.
let g:choosewin_overlay_clear_multibyte = 1
" tmux-like overlay color
let g:choosewin_color_overlay = {
            \ 'gui': ['DodgerBlue3', 'DodgerBlue3'],
            \ 'cterm': [25, 25]
            \ }
let g:choosewin_color_overlay_current = {
            \ 'gui': ['firebrick1', 'firebrick1'],
            \ 'cterm': [124, 124]
            \ }
let g:choosewin_blink_on_land      = 0 " don't blink at land
let g:choosewin_statusline_replace = 0 " don't replace statusline
let g:choosewin_tabline_replace    = 0 " don't replace tabline

" tagbar config
let g:tagbar_width=30
" let g:tagbar_autoclose=1
let g:tagbar_autofocus=1
let g:tagbar_sort=0
let g:tagbar_compact=1
let g:tagbar_show_linenumbers=1
let g:tagbar_show_visibility=0
let g:tagbar_autoshowtag=1
let g:tagbar_map_togglefold='o'
let g:tagbar_map_openallfolds='O'
let g:tagbar_map_closefold='x'
let g:tagbar_map_closeallfolds='X'
let g:tagbar_map_togglesort=''
let g:tagbar_map_toggleautoclose=''
let g:tagbar_map_zoomwin=''
nnoremap <silent><F3> :TagbarToggle<cr>

" nerd-commenter, copy from SpaceVim
let g:NERDSpaceDelims = 1
let g:NERDCreateDefaultMappings = 0
let g:NERDRemoveExtraSpaces = 1
let g:NERDCompactSexyComs = 1
" Align line-wise comment delimiters flush left instead of following code
" indentation
let g:NERDDefaultAlign = 'left'
" Allow commenting and inverting empty lines (useful when commenting a
" region)
let g:NERDCommentEmptyLines = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1
" Always use alternative delimiter
let g:NERD_c_alt_style = 1
let g:NERDCustomDelimiters = {'c': { 'left': '//', 'leftAlt': '/*', 'rightAlt': '*/' }}
" nerd commenter cfg
map <silent><leader>cs <Plug>NERDCommenterInvert
map <silent><leader>cv <Plug>NERDCommenterInvertgv
map <silent><leader>cp vip<Plug>NERDCommenterComment
map <silent><leader>cP vip<Plug>NERDCommenterInvert

"easy-motion config
"<Leader>s{char} to move to {char}
map <Leader>s <Plug>(easymotion-bd-f)
nmap <Leader>s <Plug>(easymotion-overwin-f)
"s{char}{char} to move to {char}{char}
nmap s <Plug>(easymotion-overwin-f2)
" Move to line
map <Leader>L <Plug>(easymotion-bd-jk)
nmap <Leader>L <Plug>(easymotion-overwin-line)
" Move to word
map  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)

" ultisnips config
let g:UltiSnipsEditSplit = "context"
let g:UltiSnipsSnippetsDir = "~/.vim/plugged/vim-snippets/snippets"
" let g:UltiSnipsExpandTrigger='<C-j>'
" let g:UltiSnipsJumpForwardTrigger='<C-j>'
" let g:UltiSnipsJumpBackwardTrigger='<C-j>'
let g:ulti_expand_or_jump_res = 0 "default value, just set once
inoremap <silent> <leader>q <C-R>=UltiSnips#ExpandSnippetOrJump()<cr>

let g:ulti_expand_or_jump_res = 0 "default value, just set once
function! Ulti_ExpandOrJump_and_getRes()
    call UltiSnips#ExpandSnippetOrJump()
    return g:ulti_expand_or_jump_res
endfunction
inoremap <silent> <leader>a <C-R>=(Ulti_ExpandOrJump_and_getRes() > 0)?"":""<CR>

" undotree.vim
let g:undotree_WindowLayout = 2
nnoremap <F5> :UndotreeToggle<cr>

" startify
function! s:list_commits()
    let git = 'git -C ~/repo'
    let commits = systemlist(git .' log --oneline | head -n10')
    let git = 'G'. git[1:]
    return map(commits, '{"line": matchstr(v:val, "\\s\\zs.*"), "cmd": "'. git .' show ". matchstr(v:val, "^\\x\\+") }')
endfunction
let g:startify_session_dir = $HOME .  '/.data/' . ( has('nvim') ? 'nvim' : 'vim' ) . '/session'
let g:startify_lists = [
            \ { 'header': ['   MRU'],            'type': 'files' },
            \ { 'header': ['   MRU '. getcwd()], 'type': 'dir' },
            \ { 'header': ['   Sessions'],       'type': 'sessions' },
            \ { 'header': ['   Commits'],        'type': function('s:list_commits') },
            \ ]
let g:startify_change_to_dir = 0
let g:startify_update_oldfiles = 1
let g:startify_files_number = 8
let g:startify_session_autoload    = 1
let g:startify_session_persistence = 1
let g:startify_skiplist = [
            \ 'COMMIT_EDITMSG',
            \ 'bundle/.*/doc',
            \ ]
let g:startify_custom_header =
            \ startify#fortune#cowsay('', '═','║','╔','╗','╝','╚')
hi StartifyBracket ctermfg=240
hi StartifyFile    ctermfg=147
hi StartifyFooter  ctermfg=240
hi StartifyHeader  ctermfg=114
hi StartifyNumber  ctermfg=215
hi StartifyPath    ctermfg=245
hi StartifySlash   ctermfg=240
hi StartifySpecial ctermfg=240

" Enter key binding
function! EnterInsert()
    if pumvisible()
        return "\<C-y>" . cmp#pre_complete("") . "\<C-y>"
    " elseif getline('.')[col('.') - 2]==#'{'&&getline('.')[col('.')-1]==#'}'
    "     return "\<Enter>\<esc>ko"
    else
        return "\<C-g>u\<CR>"
    endif
endfunction
" imap <silent><expr><CR> EnterInsert()

inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <expr> <PageDown> pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<PageDown>"
inoremap <expr> <PageUp>   pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<PageUp>"

" Man.vim
source $VIMRUNTIME/ftplugin/man.vim
" Linux Programmer's Manual
" <C-m> is Enter in quickfix window
nmap <C-\>a :Man <C-R>=expand("<cword>")<cr><cr>
nmap <C-\>2 :Man 2 <C-R>=expand("<cword>")<cr><cr>

" quickfix close shortcut
autocmd FileType qf noremap <buffer> q :close<CR>

" window-resize
nmap w= :res +5<CR>
nmap w- :res -5<CR>
nmap w, :vertical res +10<CR>
nmap w. :vertical res -10<CR>

" clear  ^M at the end of line in normal mode
nmap cM :%s/\r$//g<CR>:noh<CR>

" delete SPACE at the end of line
nmap cm :%s/\s\+$//<CR>:noh<CR>
