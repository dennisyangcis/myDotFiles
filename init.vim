""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"   init.vim - Configuration file for neovim.
"
"   Created : 2017-01-21
"   Author  : Tommy Yang
"   Email   : yangyinqi1991@gmail.com
"   Description :
"       This config for vim is mainly designed for C/C++/Python program coding
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" settings.
set   autowrite
set   background=dark
set   nobackup
set   cindent
set   cinoptions=:0
set   completeopt=longest,menuone
set   fileencodings=utf-8,gb2312,gbk,gb18030
set   fileformat=unix
set   foldenable
set   foldmethod=manual
set   foldlevel=128
set   helpheight=10
set   helplang=cn
set   hidden
set   history=100
set   ignorecase
set   mouse=v
set   number
set   pumheight=10
set   ruler
set   scrolloff=2
set   showcmd
set   smartindent
set   smartcase
" expand 1 tab to 4 spaces
set   expandtab
set   tabstop=4
set   shiftwidth=4

set   termencoding=utf-8
set   textwidth=80
set   whichwrap=h,l

" global ignore
set wildignore=
"common
set wildignore+=*/.svn/*,*/.git/*,*/.hg/*
set wildignore+=tags,.vim_tags
set wildignore+=*.swp
" tmp dir
set wildignore+=*/_cache/*,*/.cache/*
set wildignore+=*/_tmp/*,*/.tmp/*
" build dir
set wildignore+=*/_release/*,*/.release/*
set wildignore+=*/_build/*,*/build/*
set wildignore+=*/build/*,*/build-*/*
set wildignore+=*/bin/*,*/gen/*,*/lib/*,*/libs/*,*/obj/*
set wildignore+=*/_repo/*
" c/cpp
set wildignore+=*/.so/*,*/.o/*
" py
set wildignore+=*/.pyc/*,*/.pyo/*

set wildmode=list:longest,full
set wrap
set t_Co=256

" Restore the last quit position when open file.
autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \     exe "normal g'\"" |
    \ endif

" create file settings
autocmd BufNewFile *.cpp,*.cc,*.c,*.hpp,*.h,*.sh,*.py exec ":call SetTitle()"
func SetTitle()
	if expand("%:e") == 'sh'
		call setline(1,"\#!/bin/bash")
		call append(line("."), "")
    elseif expand("%:e") == 'py'
        call setline(1,"#!/usr/bin/env python3")
        call append(line("."),"# coding=utf-8")
		call append(line(".")+1, "")
"    elseif expand("%:e") == 'cpp'
"		call setline(1,"#include <iostream>")
"		call append(line("."), "")
"    elseif expand("%:e") == 'cc'
"		call setline(1,"#include <iostream>")
"		call append(line("."), "")
"    elseif expand("%:e") == 'c'
"		call setline(1,"#include <stdio.h>")
"		call append(line("."), "")
    elseif expand("%:e") == 'h'
		call setline(1, "#ifndef _".toupper(expand("%:r"))."_H")
		call setline(2, "#define _".toupper(expand("%:r"))."_H")
		call setline(3, "#endif")
    elseif expand("%:e") == 'hpp'
		call setline(1, "#ifndef _".toupper(expand("%:r"))."_H")
		call setline(2, "#define _".toupper(expand("%:r"))."_H")
		call setline(3, "#endif")
	endif
endfunc
autocmd BufNewFile * normal G

" some function definition:

" show function names in command line
fun! ShowFuncName()
	let lnum = line(".")
	let col = col(".")
	echohl ModeMsg
	echo getline(search("^[^ \t#/]\\{2}.*[^:]\s*$", 'bW'))
	echohl None
	call search("\\%" . lnum . "l" . "\\%" . col . "c")
endfun
map \ :call ShowFuncName()<CR>

" SHORTCUT SETTINGS:
" Set mapleader
let mapleader=","

" Space to command mode.
nnoremap <space> :
vnoremap <space> :

" Delete key
nnoremap <C-d> <DELETE>
inoremap <C-d> <DELETE>

" Switching between buffers.
" switch to normal
inoremap jk <Esc>
noremap <C-Down>  <C-W>j
noremap <C-Up>    <C-W>k
noremap <C-Left>  <C-W>h
noremap <C-Right> <C-W>l

nnoremap <A-,> <C-O>
nnoremap <A-.> <C-I>

" "cd" to change to open directory.
let OpenDir=system("pwd")
nmap <silent> <leader>cd :exe 'cd ' . OpenDir<cr>:pwd<cr>

" Specify a directory for plugins
call plug#begin('~/.vim/plugged')

" original repos on github
Plug 'Lokaltog/vim-easymotion'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'tpope/vim-surround'
Plug 'majutsushi/tagbar',{ 'on': 'TagbarToggle' }
Plug 'will133/vim-dirdiff'
Plug 'mbbill/undotree'
Plug 'tpope/vim-unimpaired'

function! BuildYCM(info)
if a:info.status == 'installed' || a:info.force
  !./install.py --clang-completer
endif
endfunction
Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM'), 'for': ['c', 'cpp', 'h', 'hpp', 'python'] }
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable'}
Plug 'jeaye/color_coded', {'for': ['c', 'cpp', 'h', 'hpp']}
Plug 'tenfyzhong/CompleteParameter.vim'

Plug 'Shougo/unite.vim'
Plug 'Shougo/vimshell.vim'
Plug 'Shougo/neossh.vim'
Plug 'Shougo/vimproc.vim', {'do' : 'make'}

Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeTabsToggle' }
Plug 'Xuyuanp/nerdtree-git-plugin', { 'on': 'NERDTreeTabsToggle' }
Plug 'jistr/vim-nerdtree-tabs', { 'on': 'NERDTreeTabsToggle' }

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'morhetz/gruvbox'
Plug 'junegunn/vim-easy-align'

" vim-scripts repos
Plug 'vim-scripts/The-NERD-Commenter'
Plug 'vim-scripts/a.vim'
Plug 'vim-syntastic/syntastic'
call plug#end()
" setup end

" PLUGIN SETTINGS:
colorscheme gruvbox

" vim-easy-align
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

"" YCM
let g:ycm_confirm_extra_conf = 0
let g:ycm_error_symbol = '>>'
let g:ycm_warning_symbol = '>*'
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_complete_in_comments = 1
let g:ycm_complete_in_strings = 1
"let g:ycm_auto_trigger = 0	"prevent unexpected completion when typing codes
let g:ycm_python_binary_path = '/usr/bin/python3'
let g:ycm_global_ycm_extra_conf = ''
nnoremap <leader>ju :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>ji :YcmCompleter GoToDefinition<CR>
nnoremap <leader>jo :YcmCompleter GoToInclude<CR>
let g:ycm_semantic_triggers =  {
  \   'c' : ['->', '.'],
  \   'cpp' : ['->', '.', '::'],
  \   'java,javascript,python' : ['.'],
  \ }

" CompleteParameter
inoremap <silent><expr> ( complete_parameter#pre_complete("()")
smap <c-j> <Plug>(complete_parameter#goto_next_parameter)
imap <c-j> <Plug>(complete_parameter#goto_next_parameter)
smap <c-k> <Plug>(complete_parameter#goto_previous_parameter)
imap <c-k> <Plug>(complete_parameter#goto_previous_parameter)

"alrLine Config
let g:airline_theme='gruvbox'
let g:airline_skip_empty_sections = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_splits = 1
let g:airline#extensions#tabline#switch_buffers_and_tabs = 0
let g:airline#extensions#tabline#show_buffers = 1
let g:Powerline_sybols = 'unicode'
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#tabline#buffer_nr_format = '%s:'
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#fnamecollapse = 1
let g:airline#extensions#tabline#fnametruncate = 0
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline#extensions#fugitiveline#enabled = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#branch#empty_message = ''
let g:airline#extensions#branch#vcs_priority = ["git", "mercurial"]

"enable/disable YCM integration >
let g:airline#extensions#ycm#enabled = 1
"set error count prefix >
let g:airline#extensions#ycm#error_symbol = 'E:'
"set warning count prefix >
let g:airline#extensions#ycm#warning_symbol = 'W:'

noremap <A-Left>  :bprevious<CR>
noremap <A-Right> :bnext<CR>
noremap <A-Up>    :bdelete<CR>

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
let g:airline#extensions#tabline#left_sep = '▶'
let g:airline#extensions#tabline#right_sep = '◀'
" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.crypt = '🔒'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.maxlinenr = '☰'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.spell = 'Ꞩ'
let g:airline_symbols.notexists = '∄'
let g:airline_symbols.whitespace = 'Ξ'


" NERDTree.vim
let g:NERDTreeQuitOnOpen=1
let g:NERDTreeShowLineNumbers=1
let g:NERDTreeWinPos="right"
let g:NERDTreeWinSize=30
let g:NERDTreeMinimalUI=1
let g:NERDTreeDirArrows=1   "dir arrow: 1-arrow  0-'+-|'
let g:NERDTreeAutoCenter=1
let NERDTreeShowHidden=1
let NERDTreeIgnore=['\.pyc','\~$','\.swp', '\.svn', '\.git']
let NERDTreeRespectWildIgnore = 1
let NERDTreeShowBookmarks=1
" close automatically when it is the last window
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

"  vim-nerdtree-tabs.vim
let g:nerdtree_tabs_open_on_console_startup=0
" always focus file window after startup
let g:nerdtree_tabs_smart_startup_focus=2
"let g:nerdtree_tabs_focus_on_files=1
"let g:nerdtree_tabs_autofind=1

" nerdtree-git-plugin.vim
let g:NERDTreeShowGitStatus = 1
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

" tagbar.vim
let g:tagbar_left=1
let g:tagbar_width=30                    "窗口宽度的设置
let g:tagbar_sort = 0                    "根据源码中出现的顺序排序
let g:tarbar_compact=1					"omitting the short help at the top of the window and the blank lines
let g:tarbar_show_linenumbers=1			"show absolute line numbers
" 执行vi 文件名，如果是c语言的程序，自动打开tagbar;vimdiff不自动打开tagbar
if &diff == 0
	" autocmd BufReadPost *.cpp,*.c,*.h,*.hpp,*.cc,*.cxx call tagbar#autoopen()
endif

"easy-motion config
"<Leader>f{char} to move to {char}
map <Leader>f <Plug>(easymotion-bd-f)
nmap <Leader>f <Plug>(easymotion-overwin-f)
"s{char}{char} to move to {char}{char}
nmap s <Plug>(easymotion-overwin-f2)
" Move to line
map <Leader>L <Plug>(easymotion-bd-jk)
nmap <Leader>L <Plug>(easymotion-overwin-line)
" Move to word
map  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)

" "ultisnips config
let g:UltiSnipsEditSplit = "context"
let g:UltiSnipsSnippetsDir = "~/.vim/bundle/vim-snippets/snippets"
let g:UltiSnipsExpandTrigger="<s-tab>"
let g:UltiSnipsListSnippets = "<c-tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" undotree.vim
let g:undotree_WindowLayout = 2

" Man.vim
source $VIMRUNTIME/ftplugin/man.vim

" vimdiff hot keys
" if you know the buffer number, you can use hot key like "'2"
" (press comma first, then press two as quickly as possible) to
" pull change from buffer number two.set up hot keys:
map <silent><leader>1 :diffget 1<CR>:diffupdate<CR>
map <silent><leader>2 :diffget 2<CR>:diffupdate<CR>
map <silent><leader>3 :diffget 3<CR>:diffupdate<CR>
map <silent><leader>4 :diffget 4<CR>:diffupdate<CR>

" dirdiff.vim
let g:DirDiffExcludes = "CVS,*.class,*.o"
let g:DirDiffIgnore = "Id:"
" ignore white space in diff
let g:DirDiffAddArgs = "-w"
let g:DirDiffEnableMappings = 1

" plugin shortcuts
function! RunShell(Msg, Shell)
	echo a:Msg . '...'
	call system(a:Shell)
	echon 'done'
endfunction

" F2 ~ F12 按键映射
nnoremap <silent> <F2> :TagbarToggle<CR>
nnoremap <F3> :NERDTreeTabsToggle<CR>
nnoremap <F5> :UndotreeToggle<CR>
"nmap  <leader><F5> :execute 'vimgrep //gj '.expand('%:p:h').'/*.c '.expand('%:p:h').'/*.h'
nmap  <F6> :execute 'vimgrep /'.expand('<cword>').'/gj '.expand('%:p:h').'/*.c '.expand('%:p:h').'/*.h'<CR>:botright cwindow<CR>
nmap  <C-F6> :vimgrep /<C-R>=expand("<cword>")<cr>/ **/*.c **/*.h<cr><C-o>:botright cwindow<cr>
nmap  <leader><F6> :vimgrep /<C-R>=expand("<cword>")<cr>/
nmap  <C-\><F6> :execute 'vimgrep //gj '.expand('%:p:h').'/*.c '.expand('%:p:h').'/*.h'
nmap  <leader><F7> :lclose<CR>

" Linux Programmer's Manual
" <C-m> is Enter in quickfix window
nmap <C-\>a :Man <C-R>=expand("<cword>")<cr><cr>
nmap <C-\>2 :Man 2 <C-R>=expand("<cword>")<cr><cr>

"其他映射
nmap <leader>zz <C-w>o
",zz  关闭光标所在窗口之外的其他所有窗口

" window-resize
nmap w= :res +5<CR>
nmap w- :res -5<CR>
nmap w, :vertical res +10<CR>
nmap w. :vertical res -10<CR>

""""""""""""""""""""""""""""""""""""
"
set noswapfile

" share system clipboard
set clipboard=unnamedplus " When possible use + register for copy-paste

"cursor line
set linespace=2
set cursorline

""""""""""""""""""""""""""""""
" 编辑文件相关配置
""""""""""""""""""""""""""""""
" 常规模式下输入 cM 清除行尾 ^M 符号
nmap cM :%s/\r$//g<CR>:noh<CR>

" 删除行尾空格
nmap cm :%s/\s\+$//<CR>:noh<CR>

" 转换成utf-8格式
nmap cu :set fileencoding=utf-8<CR>:noh<CR>

" 全部缩进(indent)对齐
nmap ci ggVG=

" 复制全部
nmap cy ggVGy

" 启用每行超过80列的字符提示（背景变brown)
"highlight MyGroup ctermbg=brown guibg=brown
"au BufWinEnter * let w:m2=matchadd('MyGroup', '\%>' . 80 . 'v.\+', -1)

" Highlight unwanted spaces
" highlight ExtraWhitespace ctermbg=red guibg=red
"autocmd BufWinEnter * match ExtraWhitespace /\s\+$\| \+\ze\t\+\|\t\+\zs \+/

" Highlight variable under cursor in Vim
let g:HlUnderCursor=0
let g:no_highlight_group_for_current_word=["Statement", "Comment", "Type", "PreProc"]
function HighlightWordUnderCursor()
	let l:syntaxgroup = synIDattr(synIDtrans(synID(line("."), stridx(getline("."), expand('<cword>')) + 1, 1)), "name")

	if (index(g:no_highlight_group_for_current_word, l:syntaxgroup) == -1)
		"exe printf('match IncSearch /\V\<%s\>/', escape(expand('<cword>'), '/\'))
		exe exists("g:HlUnderCursor")?g:HlUnderCursor?printf('match IncSearch /\V\<%s\>/', escape(expand('<cword>'), '/\')):'match none':""
	else
		"exe 'match IncSearch /\V\<\>/'
		exe 'match ExtraWhitespace /\s\+$\| \+\ze\t\+\|\t\+\zs \+/'
	endif
endfunction
map <leader>\ :call HighlightWordUnderCursor()<CR>
" define a shortcut key for enabling/disabling highlighting:
nnoremap  <C-\> :exe "let g:HlUnderCursor=exists(\"g:HlUnderCursor\")?g:HlUnderCursor*-1+1:1"<CR>
