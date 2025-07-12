#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '
export PS1="\[\e[32m\]|\[\e[m\]\[\e[32m\]-\[\e[m\]\[\e[32m\][\[\e[m\]\[\e[34m\]\u\[\e[m\]🐧\[\e[34m\]\h\[\e[m\]\[\e[32m\]]\[\e[m\]\[\e[32m\]-\[\e[m\]\[\e[32m\][\[\e[m\]\[\e[34m\]\w\[\e[m\]\[\e[32m\]]\[\e[32m\]-\[\e[32m\]|\[\e[m\]\[\e[32m\]:\[\e[m\] "
clear
fastfetch -l linux
