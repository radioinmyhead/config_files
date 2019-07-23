#!/bin/bash
set -e
set -x

# install config file
install(){
  local file=$HOME/.$1
  ls $file &>/dev/null && rm -rf $file
  echo $file
  ln -s `pwd`/$1 $file
}

install_vim(){
  type git || return 1
  if [ -d ~/.vim/bundle/Vundle.vim ];then
    echo already has
  else
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi
  type go || return 1
  type shfmt || return 1
  vim +PluginInstall +qall
  vim +GoInstallBinaries
}

# install for Darwin
darwin(){
  local files="bash_profile bash-powerline.sh vimrc gitconfig"
  for f in $files; do
    install $f
  done
  
  #install_vim
}

linux(){
type git || exit
cd `dirname $0`

files="bashrc vimrc gitconfig tmux.conf"
for f in $files; do
  install $f
done
install_vim

}


get_os(){
  if uname -a | grep -iq darwin;then
    echo darwin && return 0
  fi
  if uname -a | grep -iq linux;then
    echo linux && return 0
  fi
}

os=$(get_os)
case $os in
  darwin)
    darwin
    ;;
  linux)
    linux
    ;;
  *)
    echo fail
esac
