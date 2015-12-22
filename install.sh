#!/bin/bash
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
