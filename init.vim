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
Plug 'majutsushi/tagbar'
Plug 'will133/vim-dirdiff'
Plug 'mbbill/undotree'
Plug 'tpope/vim-unimpaired'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-jedi'
Plug 'zchee/deoplete-clang'
Plug 'tenfyzhong/CompleteParameter.vim'

Plug 'Shougo/unite.vim'
Plug 'Shougo/vimfiler.vim'
Plug 'Shougo/vimshell.vim'
Plug 'Shougo/neossh.vim'

Plug 'itchyny/lightline.vim'
Plug 'taohex/lightline-buffer'
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

" Use deoplete.
let g:deoplete#enable_at_startup = 1

" lightline config
let g:lightline = {
      \ 'colorscheme': 'jellybeans',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'readonly': 'LightlineReadonly',
      \   'gitbranch': 'fugitive#head',
      \   'fileformat': 'LightlineFileformat',
      \   'filetype': 'LightlineFiletype',
      \   'filename': 'LightlineFilename',
      \   'bufferinfo': 'lightline#buffer#bufferinfo',
      \   'mode': 'LightlineMode',
      \ },
      \ 'tabline': {
      \   'left': [ [ 'bufferinfo' ],
      \             [ 'separator' ],
      \             [ 'bufferbefore', 'buffercurrent', 'bufferafter' ], ],
      \   'right': [ [ 'close' ], ],
      \ },
      \ 'component_expand': {
      \   'buffercurrent': 'lightline#buffer#buffercurrent',
      \   'bufferbefore': 'lightline#buffer#bufferbefore',
      \   'bufferafter': 'lightline#buffer#bufferafter',
      \ },
      \ 'component_type': {
      \   'buffercurrent': 'tabsel',
      \   'bufferbefore': 'raw',
      \   'bufferafter': 'raw',
      \ },
      \ 'component': {
      \   'separator': '',
      \ },
      \ }

function! LightlineReadonly()
  return &readonly && &filetype !=# 'help' ? 'RO' : ''
endfunction

function! LightlineMode()
  return expand('%:t') ==# '__Tagbar__' ? 'Tagbar':
        \ &filetype ==# 'unite' ? 'Unite' :
        \ &filetype ==# 'vimfiler' ? 'VimFiler' :
        \ &filetype ==# 'vimshell' ? 'VimShell' :
        \ lightline#mode()
endfunction

function! LightlineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightlineFiletype()
  return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

function! LightlineFilename()
  let filename = expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
  let modified = &modified ? ' +' : ''
  return filename . modified
endfunction

" lightline buff config
set showtabline=2
" remap arrow keys
nnoremap <M-Left> :bprev<CR>
nnoremap <M-Right> :bnext<CR>

" lightline-buffer ui settings
" replace these symbols with ascii characters if your environment does not support unicode
"let g:lightline_buffer_logo = ' '
let g:lightline_buffer_readonly_icon = ''
let g:lightline_buffer_modified_icon = '✭'
let g:lightline_buffer_git_icon = ' '
let g:lightline_buffer_ellipsis_icon = '..'
let g:lightline_buffer_expand_left_icon = '◀ '
let g:lightline_buffer_expand_right_icon = ' ▶'
let g:lightline_buffer_active_buffer_left_icon = ''
let g:lightline_buffer_active_buffer_right_icon = ''
let g:lightline_buffer_separator_icon = '  '

" lightline-buffer function settings
let g:lightline_buffer_show_bufnr = 1
let g:lightline_buffer_rotate = 0
let g:lightline_buffer_fname_mod = ':t'
let g:lightline_buffer_excludes = ['vimfiler']

let g:lightline_buffer_maxflen = 30
let g:lightline_buffer_maxfextlen = 3
let g:lightline_buffer_minflen = 16
let g:lightline_buffer_minfextlen = 3
let g:lightline_buffer_reservelen = 20

" vimfiler config

function! OpenVimfiler() abort
    if bufnr('vimfiler') == -1
        silent VimFiler
        if exists(':AirlineRefresh')
            AirlineRefresh
        endif
        wincmd p
        if &filetype !=# 'startify'
            IndentLinesToggle
            IndentLinesToggle
        endif
        wincmd p
    else
        silent VimFiler
        doautocmd WinEnter
        if exists(':AirlineRefresh')
            AirlineRefresh
        endif
    endif
endfunction

let g:vimfiler_as_default_explorer = 1
let g:vimfiler_restore_alternate_file = 1
" call vimfiler#set_execute_file('txt', 'notepad')
" call vimfiler#set_execute_file('c', ['gvim', 'notepad'])
" Enable file operation commands.
" Edit file by tabedit.
call vimfiler#custom#profile('default', 'context', {
      \ 'edit_action' : 'tabopen',
      \ 'toggle' : 1,
      \ 'auto_expand' : 1,
      \ 'parent': 0,                                                                                                                                                                                           
      \ 'status' : 1,                                                                                                                                                                                         
      \ 'safe' : 0,                                                                                                                                                                                            
      \ 'split' : 1,
      \ 'hidden': 1,
      \ 'no_quit' : 1,
      \ 'force_hide' : 0,
      \ 'direction' : 'rightbelow',
      \ 'winwidth' : 40,
      \ 'winminwidth' : 30,
      \ })
" Like Textmate icons.
let g:vimfiler_tree_leaf_icon = ' '
let g:vimfiler_tree_opened_icon = '▾'
let g:vimfiler_tree_closed_icon = '▸'
let g:vimfiler_file_icon = '-'
let g:vimfiler_marked_file_icon = '*'
let g:vimfiler_readonly_file_icon = '√'
let g:vimfiler_ignore_filter = ['matcher_ignore_wildignore']
" Use trashbox.
" Windows only and require latest vimproc.
"let g:unite_kind_file_use_trashbox = 1

" tagbar.vim
let g:tagbar_left=1
let g:tagbar_width=30                    "窗口宽度的设置
let g:tagbar_sort = 0                    "根据源码中出现的顺序排序
let g:tarbar_compact=1					"omitting the short help at the top of the window and the blank lines
let g:tarbar_show_linenumbers=1			"show absolute line numbers
" 执行vi 文件名，如果是c语言的程序，自动打开tagbar;vimdiff不自动打开tagbar
if &diff == 0
"	autocmd BufReadPost *.cpp,*.c,*.h,*.hpp,*.cc,*.cxx call tagbar#autoopen()
endif

noremap <A-Left>  :bprevious<CR>
noremap <A-Right> :bnext<CR>
noremap <leader>d	:bdelete<CR>

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
nnoremap <F3> :call OpenVimfiler()<CR>
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

" 启用每行超过80列的字符提示（背景变brown)
"highlight MyGroup ctermbg=brown guibg=brown
"au BufWinEnter * let w:m2=matchadd('MyGroup', '\%>' . 80 . 'v.\+', -1)

" Highlight unwanted spaces
highlight ExtraWhitespace ctermbg=red guibg=red
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
