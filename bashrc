# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -lF'
alias la='ls -A'
alias l='ls -CF'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
#if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
#    . /etc/bash_completion
#fi

# User specific aliases and functions

function get-host-name {
    hostname|sed 's/^[0-9]*_//'
}
function git-branch-name {
    git symbolic-ref HEAD 2>/dev/null | awk -F'heads/' '{print $2}'
}
function git-branch-prompt {
    local branch=`git-branch-name`
    if [ $branch ]; then printf "[%s]" $branch; fi
}

#PS1="[\u@\h]\[\033[0;36m\][\W]\[\033[0m\]\[\033[0;32m\]\$(git-branch-prompt)\[\033[0m\]\\\$ "
PS1="\[\033[0;31m\]$(get-host-name)>\[\033[0;36m\]\W>\[\033[0;32m\]\$(git-branch-prompt)\[\033[0m\]\\\$ "

export LANG=en_US.utf8 LC_ALL=en_US.utf8
# golang
export GOROOT=/usr/local/go
export GO111MODULE=on
export GOPROXY=http://goproxy.io,direct
if [ -f $GOROOT/bin/go ];then
  GOPATH=~/go
  PATH=~/go/bin:/usr/local/go/bin:$PATH
fi

if [ -f /usr/local/node/bin/node ];then
  PATH=/usr/local/node/bin:$PATH
fi

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

export EDITOR=/usr/local/bin/nvim
alias vi=nvim
alias vim=nvim
alias vimdiff='nvim -d'
alias cp='cp -i'
alias ds='du --max-depth=1|sort -n'
alias fomnitty='omnitty -T 80 -f'
alias mv='mv -i'
alias rm='rm -i --preserve-root'
alias urldecode='python -c "import sys, urllib as ul; print ul.unquote_plus(sys.argv[1])"'
alias urlencode='python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1])"'
alias htmldecode='python -c "import HTMLParser,sys;print HTMLParser.HTMLParser().unescape(sys.argv[1])"'
alias ssh='ssh -o StrictHostKeyChecking=no'
alias lunactl='LUNAKEY=QFv1TkSbJfVHVjTnXcEP9jexPfH4Daxy LUNAURL=https://lunav2.megvii-inc.com/v1 luna ctl'
#alias node='docker run -it --rm -v /root/code_nodejs:/code -w /code node node'
alias swagger="docker run --rm -it -v $HOME:$HOME -w $(pwd) quay.io/goswagger/swagger"
alias py="python3"


export SAIO_BLOCK_DEVICE=/root/srv/swift-disk
export SWIFT_TEST_CONFIG_FILE=/etc/swift/test.conf
export PATH=/root/bin:/root/swift/bin:$PATH
export PATH=/root/go/src/autossh:$PATH

complete -C /usr/bin/aws_completer aws

export HISTSIZE=10000

#PROG=lunactl source /root/tongo/src/github.com/urfave/cli/autocomplete/bash_autocomplete
