# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

export VIM=~/vim/share/vim/vim74
export CSCOPE_DB=./cscope.out:./cscope.in.out:./cscope.po.out
source ~/vim/setenv
alias ls="ls --color"

# User specific aliases and functions
