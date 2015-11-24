"====================================
"    Filename: .vimrc
"    Author:   YYQ
"    Version:  1.0.0
"    Email:    yangyinqi1991@gmail.com
"    Date: 2015-11-23
"=============================================
"==================================
"    Vim基本配置
"===================================

"关闭vi的一致性模式 避免以前版本的一些Bug和局限
set nocompatible
"配置backspace键工作方式
set backspace=indent,eol,start
"显示行号
set number
"设置在编辑过程中右下角显示光标的行列信息
set ruler
"当一行文字很长时取消换行
"set nowrap

"在状态栏显示正在输入的命令
set showcmd

"设置历史记录条数
set history=1000

"设置取消备份 禁止临时文件生成
set nobackup
set noswapfile

"突出现实当前行列
"set cursorline
set cursorcolumn

"设置匹配模式 类似当输入一个左括号时会匹配相应的那个右括号
set showmatch

"设置C/C++方式自动对齐
set autoindent
set cindent

"开启语法高亮功能
syntax enable
syntax on

"指定配色方案为256色
set t_Co=256

"设置搜索时忽略大小写
set ignorecase

"设置在Vim中可以使用鼠标 防止在Linux终端下无法拷贝
set mouse=a

"主题设置
"colorscheme molokai

"设置Tab宽度
set tabstop=4
"设置自动对齐空格数
set shiftwidth=4
"设置按退格键时可以一次删除4个空格
set softtabstop=4
"设置按退格键时可以一次删除4个空格
set smarttab
"将Tab键自动转换成空格 真正需要Tab键时使用[Ctrl + V + Tab]
set expandtab

"设置编码方式
set encoding=utf-8
"自动判断编码时 依次尝试一下编码
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
"设置当前正在编辑的文件被外部程序修改后自动在VIM加载
if exists("&autoread")
    set autoread
endif 
"括号自动补全
:inoremap ( ()<ESC>i
:inoremap ) <c-r>=ClosePair(')')<CR>
:inoremap { {<CR>}<ESC>O
:inoremap } <c-r>=ClosePair('}')<CR>
:inoremap [ []<ESC>i
:inoremap ] <c-r>=ClosePair(']')<CR>
:inoremap " ""<ESC>i
:inoremap ' ''<ESC>i
function! ClosePair(char)
    if getline('.')[col('.') - 1] == a:char
        return "\<Right>"
    else
        return a:char
    endif
endfunction
"拼写检查
map <leader>sn ]
map <leader>sp [
map <leader>sa zg
map <leader>s? z=
"允许插件
filetype plugin on
"启动智能补全
filetype plugin indent on
"============================================
"	VIM基本设置结束
"===========================================

"=============================================
"	Vundle设置
"=============================================
set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

"使用Vundle来管理Vundle
Bundle 'gmarik/vundle'
"符号显示插件
Bundle 'taglist.vim'
"树形文件显示
Bundle 'scrooloose/nerdtree'
"窗口管理
Bundle 'winmanager'
"补全插件
"Bundle 'Valloric/YouCompleteMe'
Bundle 'OmniCppComplete'
"Bundle 'SuperTab'
"配色插件
Bundle 'Molokai'
"状态栏增强
Bundle 'bling/vim-airline'
"语法检查
Bundle 'scrooloose/syntastic'
"YCM依赖插件
Bundle 'Valloric/ListToggle'
"C/C++插件
Bundle 'c.vim'
".c与.h快速切换
Bundle 'a.vim'
"...
"Vundle配置必须 开启插件
filetype plugin indent on
"============================================
"	Vundle设置结束
"============================================
"
"============================================
"   配色插件
"============================================
colorscheme molokai
let g:molokai_original = 1
"============================================
"   补全插件
"============================================
set nocp
filetype plugin on

let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_ShowPrototypeInAbbr = 1 " 显示函数参数列表
let OmniCpp_MayCompleteDot = 1   " 输入 .  后自动补全
let OmniCpp_MayCompleteArrow = 1 " 输入 -> 后自动补全
let OmniCpp_MayCompleteScope = 1 " 输入 :: 后自动补全
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
" 自动关闭补全窗口
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menuone,menu,longest

highlight Pmenu    guibg=darkgrey  guifg=black 
highlight PmenuSel guibg=lightgrey guifg=black
"============================================
"    设置supertab
"============================================
"let g:SuperTabDefaultCompletionType="context"
"============================================
"    设置ctags
"    ========================================
" 按下F8重新生成tag文件，并更新taglist
map <F8> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR><CR> :TlistUpdate<CR>
imap <F8> <ESC>:!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR><CR> :TlistUpdate<CR>
set tags=tags;
set autochdir
"set tags+=./tags "add current directory's generated tags file
"set tags+=~/Vim_Tags/tags "add new tags file
"(刚刚生成tags的路径，在ctags -R生成tags文件后，不要将tags移动到别的目录，否则ctrl+］时，会提示找不到源码文件)
"============================================
"    设置taglist
"    ========================================
let Tlist_Ctags_Cmd='ctags' "因为我们放在环境变量里，所以可以直接执行
let Tlist_Use_Right_Window=0 "让窗口显示在右边，0的话就是显示在左边
let Tlist_Show_One_File=0 "让taglist可以同时展示多个文件的函数列表
let Tlist_File_Fold_Auto_Close=1 "非当前文件，函数列表折叠隐藏
let Tlist_Exit_OnlyWindow=1 "当taglist是最后一个分割窗口时，自动推出vim
"是否一直处理tags.1:处理;0:不处理
let Tlist_Process_File_Always=1 "实时更新tags
let Tlist_Inc_Winwidth=0
"============================================
"   设置nerdtree,winmaneger
"   =========================================
let g:NERDTree_title="[NERDTree]" 
let g:winManagerWindowLayout="NERDTree|TagList" 
function! NERDTree_Start() 
    exec 'NERDTree' 
endfunction 
function! NERDTree_IsValid() 
    return 1 
endfunction 
"-- WinManager setting
let g:winManagerWindowLayout='FileExplorer|TagList' " 设置我们要管理的插件
nmap wm :WMToggle<cr>
