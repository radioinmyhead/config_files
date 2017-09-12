#!/bin/bash
type git || exit
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
cd `dirname $0`
function install(){
  local file=$HOME/.$1
  ls $file &>/dev/null && rm -rf $file
  echo $file
  ln -s `pwd`/$1 $file
}

files="bashrc vimrc gitconfig tmux.conf"
for f in $files; do
  install $f
done

vim +PluginInstall +qall
go get github.com/constabulary/gb/...
go get github.com/tools/godep
go get -u github.com/nsf/gocode

