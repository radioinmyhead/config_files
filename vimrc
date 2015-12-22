set mouse=a
" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" php file
autocmd FileType php set nu shiftwidth=2 ts=2 expandtab
" go file
autocmd FileType go set nu shiftwidth=4 ts=4
au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>c <Plug>(go-coverage)

" Emacs-style start of line / end of line navigation
nnoremap <silent> <C-a> ^
nnoremap <silent> <C-e> $
vnoremap <silent> <C-a> ^
vnoremap <silent> <C-e> $
inoremap <silent> <C-a> <esc>^i
inoremap <silent> <C-e> <esc>$i

" Fix Alt key in MacVIM GUI
" TODO - Fix in MacVIM terminal
if has("gui_macvim")
  set macmeta
endif

" Emacs-style start of file / end of file navigation
nnoremap <silent> <M-<> gg
nnoremap <silent> <M->> G$
vnoremap <silent> <M-<> gg
vnoremap <silent> <M->> G$
inoremap <silent> <M-<> <esc>ggi
inoremap <silent> <M->> <esc>G$i

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Keep Plugin commands between vundle#begin/end.
Plugin 'fatih/vim-go'
Plugin 'cespare/vim-toml'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
