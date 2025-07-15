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
#fastfetch -l linux
durfetch -r
clear
if command -v zoxide > /dev/null; then
  eval "$(zoxide init bash)"
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
# Source the Lazyman shell initialization for aliases and nvims selector
# shellcheck source=.config/nvim-Lazyman/.lazymanrc
[ -f ~/.config/nvim-Lazyman/.lazymanrc ] && source ~/.config/nvim-Lazyman/.lazymanrc
# Source the Lazyman .nvimsbind for nvims key binding
# shellcheck source=.config/nvim-Lazyman/.nvimsbind
[ -f ~/.config/nvim-Lazyman/.nvimsbind ] && source ~/.config/nvim-Lazyman/.nvimsbind
