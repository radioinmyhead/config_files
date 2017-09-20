export LS_OPTIONS='--color=auto'
export CLICOLOR='Yes'
export LSCOLORS='Exfxcxdxbxegedabagacad'

alias py='python3'

export GOPATH=~/radio/go
PATH=${GOPATH}/bin:$PATH

#source ~/.bash-powerline.sh

function _update_ps1() {
  export PS1="$(powerline-shell-go bash $? 2> /dev/null)"
}

export PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
