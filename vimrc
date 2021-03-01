" An example for a vimrc file.
"
" Maintainer:	radio <xiaotongzh@qq.com>
" Last change:	2015-12-22
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.

filetype off                  " required

" https://github.com/VundleVim/Vundle.vim/issues/690
set shell=/bin/bash

" set auto save file
set autowrite

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
set rtp+=$GOPATH/src/github.com/golang/lint/misc/vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Keep Plugin commands between vundle#begin/end.
Plugin 'fatih/vim-go'
Plugin 'cespare/vim-toml'
Plugin 'mxw/vim-jsx'
Plugin 'z0mbix/vim-shfmt'
Plugin 'posva/vim-vue'
Plugin 'prettier/vim-prettier'

" All of your Plugins must be added before the following line
call vundle#end()            " required

set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set incsearch		" do incremental searching

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
  hi comment ctermfg=blue
endif

let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue PrettierAsync


" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78
  " For ruby files set
  autocmd FileType ruby set nu sw=4 expandtab 
  " For PHP files
  autocmd FileType php set nu sw=2 expandtab
  " For js files
  autocmd FileType javascript set nu sw=2 expandtab
  " For py files
  au BufNewFile,BufRead *.py
			  \ set nu |
			  \ set tabstop=4 |
			  \ set softtabstop=4 |
			  \ set shiftwidth=4 |
			  \ set textwidth=79 |
			  \ set expandtab |
			  \ set autoindent |
			  \ set fileformat=unix |
  autocmd FileType python nnoremap <LocalLeader>= :0,$!yapf<CR>
  " For GO files
  " run :GoBuild or :GoTestCompile based on the go file
  function! s:build_go_files()
    let l:file = expand('%')
    if l:file =~# '^\f\+_test\.go$'
      call go#test#Test(0, 1)
    elseif l:file =~# '^\f\+\.go$'
      call go#cmd#Build(0)
    endif
  endfunction
  autocmd FileType go set nu shiftwidth=4 ts=4
  autocmd FileType go nmap <leader>r <Plug>(go-run)
  autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
  autocmd FileType go nmap <leader>t <Plug>(go-test)
  autocmd FileType go nmap <leader>c <Plug>(go-coverage)
  autocmd FileType go nmap <leader>i <Plug>(go-info)
  au BufNewFile,BufRead *.tmpl set filetype=html
  autocmd FileType html set nu shiftwidth=2 ts=2 expandtab
  " For bash files
  autocmd FileType sh set nu shiftwidth=2 ts=2 expandtab
  " For message file
  autocmd BufNewFile,BufReadPost messages.* set filetype=messages

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

  " 退出插入模式指定类型的文件自动保存
  au InsertLeave *.go,*.sh,*.php write

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Fix Alt key in MacVIM GUI
" TODO - Fix in MacVIM terminal
if has("gui_macvim")
  set macmeta
endif

" Emacs-style start of line / end of line navigation
nnoremap <silent> <C-a> ^
nnoremap <silent> <C-e> $
vnoremap <silent> <C-a> ^
vnoremap <silent> <C-e> $
inoremap <silent> <C-a> <esc>^i
inoremap <silent> <C-e> <esc>$i

" Emacs-style start of file / end of file navigation
nnoremap <silent> <M-<> gg
nnoremap <silent> <M->> G$
vnoremap <silent> <M-<> gg
vnoremap <silent> <M->> G$
inoremap <silent> <M-<> <esc>ggi
inoremap <silent> <M->> <esc>G$i

let g:go_fmt_command = "goimports"
let g:go_version_warning = 0
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'
let g:go_list_type = "quickfix"
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
"let g:go_auto_type_info = 1

let g:prettier#autoformat = 0

map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>
nnoremap <leader>a :cclose<CR>
"let mapleader = ","

" help
" :PluginInstall
" install all plugin
" :PluginUpdate
" update plugin
