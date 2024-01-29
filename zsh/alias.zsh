#!/usr/bin/env bash

# Quick Change
## Go nvim config
alias gnv="cd ~/.config/nvim/lua/"
## Go kube lab
alias gkl="cd ~/repos/projects/personal/kubelab/"


alias k="kubectl"
# alias cc="/usr/bin/cat"
alias python="python3"
eval "$(register-python-argcomplete pipx)"
alias history="history -E"
alias myip="curl http://ipecho.net/plain; echo"
alias ls='ls --color=tty'
alias grep='grep  --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn}'
alias openzs="vi ~/.zshrc"
alias ls="colorls"
alias la="colorls -alhrt"
alias ff="fzf"
alias cat="bat"
alias batcat="bat"
alias vs_kill='ps -ef | grep -i "Code Helper" | tr -s " " | cut -d " " -f 3 | xargs -L 1 -I {} sh -c "kill -9 {}"'

alias it="it2copy"
