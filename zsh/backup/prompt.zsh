#!/usr/bin/env bash

# Prompt
export PROMPT='%F%{$fg[yellow]%}[%*]%f %F{219}%n%f@%F{223}%u%f%m:%2d %# '
#PROMPT='%(?.%F{green}√.%F{red}?%?)%f %B%F{240}%1~%f%b %u@%m:%d %# '
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst

#\$vcs_info_msg_0_
zstyle ':vcs_info:git:*' formats '%F{blue}(%b)%r%f'
zstyle ':vcs_info:*' enable git
export RPROMPT="\$vcs_info_msg_0_ %(?.%F{green}√.%F{red}?%?"