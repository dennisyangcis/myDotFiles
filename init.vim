"=============================================================================
" dark_powered.vim --- Dark powered mode of SpaceVim
" Copyright (c) 2016-2017 Wang Shidong & Contributors
" Author: Wang Shidong < wsdjeg at 163.com >
" URL: https://spacevim.org
" License: GPLv3
"=============================================================================


" SpaceVim Options: {{{
let g:spacevim_enable_debug = 1
let g:spacevim_realtime_leader_guide = 1
let g:spacevim_enable_tabline_filetype_icon = 1
let g:spacevim_enable_statusline_display_mode = 0
let g:spacevim_enable_os_fileformat_icon = 1
let g:spacevim_buffer_index_type = 1
let g:spacevim_enable_vimfiler_welcome = 1
let g:spacevim_default_indent = 4
let g:spacevim_relativenumber = 0
let g:spacevim_enable_debug = 1
" }}}

" SpaceVim Layers: {{{
" utils
call SpaceVim#layers#load('autocomplete')
call SpaceVim#layers#load('checkers')
call SpaceVim#layers#load('debug')
" languages
call SpaceVim#layers#load('lang#c',
        \ {
        \ 'libclang_path' : '/usr/lib/libclang.so',
        \ }
        \ )
call SpaceVim#layers#load('lang#java')
call SpaceVim#layers#load('lang#javascript')
call SpaceVim#layers#load('lang#python')
call SpaceVim#layers#load('lang#vim')
call SpaceVim#layers#load('lang#markdown')
call SpaceVim#layers#load('lang#html')
" tools
call SpaceVim#layers#load('VersionControl')
call SpaceVim#layers#load('git')
call SpaceVim#layers#load('github')
call SpaceVim#layers#load('shell',
        \ {
        \ 'default_position' : 'bottom',
        \ 'default_height' : 30,
        \ 'default_shell' : 'terminal',
        \ }
        \ )
call SpaceVim#layers#load('ui')
call SpaceVim#layers#load('colorscheme')
call SpaceVim#layers#load('tags')
call SpaceVim#layers#load('cscope')
call SpaceVim#layers#load('unite')
" }}}

" Spacevim Custom Settings:{{{
let g:spacevim_colorscheme = 'one'
let g:spacevim_colorscheme_bg = 'dark'
" }}}
