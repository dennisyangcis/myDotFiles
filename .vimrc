""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" .vimrc - Vim configuration file.
"
"   Created: 2017-01-21
"	Author : Tommy Yang
"	Email	: yangyinqi1991@gmail.com
"	Description:
"		This config for vim is mainly designed for C/C++/Python program coding
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" To use VIM settings, out of VI compatible mode.
set nocompatible
" filetype plugin indent on
filetype on
syntax enable
syntax on
" Other settings.
set   autoindent
set   autoread
set   autowrite
set   background=dark
set   backspace=indent,eol,start
set   nobackup
set   cindent
set   cinoptions=:0
set   completeopt=longest,menuone
set   noexpandtab
set   fileencodings=utf-8,gb2312,gbk,gb18030
set   fileformat=unix
set   foldenable
set   foldmethod=manual
set   foldlevel=128
set   guioptions-=T
set   guioptions-=m
set   guioptions-=r
set   guioptions-=l		"remove toolbars on gvim
set   helpheight=10
set   helplang=cn
set   hidden
set   history=100
set   hlsearch
set   ignorecase
set   incsearch
set   mouse=v
set   number
set   pumheight=10
set   ruler
set   scrolloff=2
set   shiftwidth=4
set   showcmd
set   smartindent
set   smartcase
set   tabstop=4
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

set   wildmenu
set   wildmode=list:longest,full
set wrap
set t_Co=256


" AUTO COMMANDS:
" auto expand tab to blanks
"autocmd FileType c,cpp set expandtab
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
        call setline(1,"#!/usr/bin/env python")
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
let mapleader="'"

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

" "cd" to change to open directory.
let OpenDir=system("pwd")
nmap <silent> <leader>cd :exe 'cd ' . OpenDir<cr>:pwd<cr>

" vundle.vim 插件管理器
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

filetype plugin indent on     " required!
Bundle 'gmarik/vundle'

" My Bundles here:  /* 插件配置格式 */
" original repos on github （Github网站上非vim-scripts仓库的插件，按下面格式填写）
Bundle 'Lokaltog/vim-easymotion'
"Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
Bundle 'tpope/vim-fugitive'
Bundle 'airblade/vim-gitgutter'
Bundle 'msanders/snipmate.vim'
Bundle 'tpope/vim-surround'
Bundle 'Valloric/YouCompleteMe'
Bundle 'majutsushi/tagbar'
Bundle 'weynhamz/vim-plugin-minibufexpl'
Bundle 'kien/ctrlp.vim'
Bundle 'tacahiroy/ctrlp-funky'
Bundle 'mbbill/VimExplorer',{'on': 'VE'}
Bundle 'will133/vim-dirdiff'
Bundle 'mbbill/undotree'
Plugin 'rdnetto/YCM-Generator', { 'branch': 'stable'}
Plugin 'jeaye/color_coded'		"semantic highlighting with vim for c/cpp/oc
Bundle 'tpope/vim-unimpaired'
"running shell on vim
Bundle 'oplatek/Conque-Shell'
Plugin  'vim-airline/vim-airline'
Bundle 'vim-airline/vim-airline-themes'
Bundle 'jistr/vim-nerdtree-tabs'
Bundle 'Xuyuanp/nerdtree-git-plugin'
"Plugin 'fugalh/desert.vim'		"use twilighted instead in order to fit the color_coded
" vim-scripts repos  （vim-scripts仓库里的，按下面格式填写）
"Bundle 'L9'
"Bundle 'FuzzyFinder'
Bundle 'genutils'
Bundle 'lookupfile'
Bundle 'The-NERD-tree'
Bundle 'The-NERD-Commenter'
Bundle 'mru.vim'
Bundle 'ZoomWin'
Bundle 'a.vim'

Bundle 'gitv'

" non github repos   (非上面两种情况的，按下面格式填写)
"Bundle 'git://git.wincent.com/command-t.git'

" vundle setup end


" PLUGIN SETTINGS:
"colorscheme desert
colorscheme twilighted

" tagbar.vim
let g:tagbar_left=1
let g:tagbar_width=30                    "窗口宽度的设置
let g:tagbar_sort = 0                    "根据源码中出现的顺序排序
let g:tarbar_compact=1					"omitting the short help at the top of the window and the blank lines
let g:tarbar_show_linenumbers=1			"show absolute line numbers
" 执行vi 文件名，如果是c语言的程序，自动打开tagbar;vimdiff不自动打开tagbar
if &diff == 0
	"autocmd BufReadPost *.cpp,*.c,*.h,*.hpp,*.cc,*.cxx call tagbar#autoopen()
endif
nmap  <leader>tt :TagbarToggle<CR>

"alrLine Config
if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"
let g:airline_exclude_filename = []
let g:Powerline_symbols='fancy'
let g:airline_powerline_fonts=0
let Powerline_symbols='fancy'
let g:bufferline_echo=0
set laststatus=2
set t_Co=256
"set fillchars+=stl:\ ,stlnc:\
set guifont=Lucida_Console:h10
let g:airline_mode_map = {
	\ '__' : '-',
	\ 'n'  : 'N',
	\ 'i'  : 'I',
	\ 'R'  : 'R',
	\ 'c'  : 'C',
	\ 'v'  : 'V',
	\ 'V'  : 'V',
	\ '' : 'V',
	\ 's'  : 'S',
	\ 'S'  : 'S',
	\ '' : 'S',
\ }

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

" NERDTree.vim
let g:NERDTreeWinPos="right"
let g:NERDTreeWinSize=30
let g:NERDTreeShowLineNumbers=1
let g:NERDTreeQuitOnOpen=1
let g:NERDTreeDirArrows=0   "目录箭头: 1显示箭头  0传统+-|号
let g:NERDTreeAutoCenter=1
" 是否显示隐藏文件
let NERDTreeShowHidden=1
" 忽略以下文件的显示
let NERDTreeIgnore=['\.pyc','\~$','\.swp', '\.svn', '\.git']
" 显示书签列表
let NERDTreeShowBookmarks=1
"autocmd vimenter * NERDTree "打开vim时自动打开NERDTree
" NERDTree是最后一个窗口，它自动关闭
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

"  vim-nerdtree-tabs.vim
" 在终端启动vim时，共享NERDTree
let g:nerdtree_tabs_open_on_console_startup=0
" always focus file window after startup
let g:nerdtree_tabs_smart_startup_focus=2
"let g:nerdtree_tabs_focus_on_files=1
"let g:nerdtree_tabs_autofind=1

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
  \   'objc' : ['->', '.', 're!\[[_a-zA-Z]+\w*\s', 're!^\s*[^\W\d]\w*\s',
  \             're!\[.*\]\s'],
  \   'ocaml' : ['.', '#'],
  \   'cpp,objcpp' : ['->', '.', '::'],
  \   'perl' : ['->'],
  \   'php' : ['->', '::'],
  \   'cs,java,javascript,typescript,d,python,perl6,scala,vb,elixir,go' : ['.'],
  \   'ruby' : ['.', '::'],
  \   'lua' : ['.', ':'],
  \   'erlang' : [':'],
  \ }

" MiniBufExpl Config
hi MBENormal               guifg=#808080 guibg=fg
hi MBEChanged              guifg=#CD5907 guibg=fg
hi MBEVisibleNormal        guifg=#5DC2D6 guibg=fg
hi link MBEVisibleChanged Error
hi MBEVisibleActiveNormal  guifg=#A6DB29 guibg=fg
hi MBEVisibleActiveChanged guifg=#F1266F guibg=fg
map <Leader>mbe :MBEOpen<cr>
map <Leader>mbc :MBEClose<cr>
map <Leader>mbt :MBEToggle<cr>
map <A-Up>		:MBEOpenAll<cr>
map <A-Down>	:MBECloseAll<cr>
map <Leader>mta :MBEToggleAll<cr>
nmap <A-Right>  :MBEbp<CR>
nmap <A-Left>	:MBEbn<CR>
nmap <Leader>d	:MBEbd<cr>	"remove the current buffer
let g:miniBufExplMaxSize=3
let g:miniBufExplCycleArround=1
let g:miniBufExplHideWhenDiff=0

" color_coded config
" Disbale color_coded in diff mode
if &diff
	let g:color_coded_enbaled = 0
else
	let g:color_coded_enbaled = 1
endif
let g:color_coded_filetypes = ['c', 'cpp', 'h', 'hpp', 'cc']	"controls the filetypes which color_coded will try to compile


" LookupFile setting
let g:LookupFile_TagExpr='"./tags.o.fn"'
let g:LookupFile_MinPatLength=2
let g:LookupFile_PreserveLastPattern=0
let g:LookupFile_PreservePatternHistory=1
let g:LookupFile_AlwaysAcceptFirst=1
let g:LookupFile_AllowNewFiles=0

" undotree.vim
let g:undotree_WindowLayout = 2

" Man.vim
source $VIMRUNTIME/ftplugin/man.vim

" snipMate
let g:snips_author="Yang Yinqi"
let g:snips_email="yangyinqi1991@gmail.com"
let g:snips_copyright="Yang Yinqi"

" Conque-Shell.vim
" 水平分割出一个bash
nnoremap <C-\>b :ConqueTermSplit bash<CR><CR>
" 垂直分割出bash
nnoremap <C-\>vb :ConqueTermVSplit bash<CR><CR>
" 在tab中打开一个bash
nnoremap <C-\>t :ConqueTermTab bash<CR><CR>
" F9:将选中的文本，发送到Conque-Shell的交互程序中

" vimdiff hot keys
" if you know the buffer number, you can use hot key like ",2"
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

" ZoomWinPlugin.vim
" Zoom / Restore window.
function! s:ZoomToggle() abort
    if exists('t:zoomed') && t:zoomed
        execute t:zoom_winrestcmd
        let t:zoomed = 0
    else
        let t:zoom_winrestcmd = winrestcmd()
        resize
        vertical resize
        let t:zoomed = 1
    endif
endfunction
command! ZoomToggle call s:ZoomToggle()
nnoremap <silent> <C-A> :ZoomToggle<CR>

" F2 ~ F12 按键映射
nmap  <F3> :exec 'MRU' expand('%:p:h')<CR>
"nmap  <F4> :NERDTreeToggle<cr>
nmap  <F4> :NERDTreeTabsToggle<cr>
nmap  <C-\><F4> :NERDTreeTabsFind<CR>
nmap  <leader><F4> :silent! VE .<cr>

nmap  <F5> <Plug>LookupFile<cr>
nmap  <C-F5> :UndotreeToggle<cr>
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
nmap w= :res +15<CR>
nmap w- :res -15<CR>
nmap w, :vertical res +30<CR>
nmap w. :vertical res -30<CR>

""""""""""""""""""""""""""""""""""""
"
set noswapfile
set guifont=DejaVuSansMono\ 11

""""""""""""""""""""""""""""""
"实现vim和终端及gedit等之间复制、粘贴的设置
""""""""""""""""""""""""""""""
" 让VIM和ubuntu(X Window)共享一个粘贴板
set clipboard=unnamedplus " 设置vim使用"+寄存器(粘贴板)，"+寄存器是代表ubuntu的粘贴板。

"cursor line
set linespace=2
set cursorline
highlight CursorLineNr gui=reverse guibg=NONE guifg=NONE
highlight CursorLineNr cterm=reverse ctermbg=NONE ctermfg=NONE

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

" 启用每行超过80列的字符提示（背景变black）
highlight MyGroup ctermbg=black guibg=black
au BufWinEnter * let w:m2=matchadd('MyGroup', '\%>' . 80 . 'v.\+', -1)

" Highlight unwanted spaces
highlight ExtraWhitespace ctermbg=red guibg=red
"autocmd BufWinEnter * match ExtraWhitespace /\s\+$\| \+\ze\t\+\|\t\+\zs \+/

" Highlight variable under cursor in Vim
let g:HlUnderCursor=0
let g:no_highlight_group_for_current_word=["Statement", "Comment", "Type", "PreProc"]
function s:HighlightWordUnderCursor()
	let l:syntaxgroup = synIDattr(synIDtrans(synID(line("."), stridx(getline("."), expand('<cword>')) + 1, 1)), "name")

	if (index(g:no_highlight_group_for_current_word, l:syntaxgroup) == -1)
		"exe printf('match IncSearch /\V\<%s\>/', escape(expand('<cword>'), '/\'))
		exe exists("g:HlUnderCursor")?g:HlUnderCursor?printf('match IncSearch /\V\<%s\>/', escape(expand('<cword>'), '/\')):'match none':""
	else
		"exe 'match IncSearch /\V\<\>/'
		exe 'match ExtraWhitespace /\s\+$\| \+\ze\t\+\|\t\+\zs \+/'
	endif
endfunction
autocmd CursorMoved * call s:HighlightWordUnderCursor()
" define a shortcut key for enabling/disabling highlighting:
nnoremap  <C-\><F3> :exe "let g:HlUnderCursor=exists(\"g:HlUnderCursor\")?g:HlUnderCursor*-1+1:1"<CR>
