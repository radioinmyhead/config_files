# enable color support of ls and also add handy aliases
alias ls='ls -G'
alias grep='grep --color'

export GOPATH=~/tongo
PATH=~/tongo/bin:$PATH

#source ~/.bash-powerline.sh

function _update_ps1() {
  export PS1="$(powerline-shell-go bash $? 2> /dev/null)"
}

export PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
