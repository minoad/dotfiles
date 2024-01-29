#!/usr/bin/env bash

# Prompt
export PROMPT='%F%{$fg[yellow]%}[%*]%f %F{219}%n%f@%F{223}%u%f%m:%3d %# '
#PROMPT='%(?.%F{green}√.%F{red}?%?)%f %B%F{240}%1~%f%b %u@%m:%d %# '
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst

#\$vcs_info_msg_0_
zstyle ':vcs_info:git:*' formats '%F{blue}(%b)%r%f'
zstyle ':vcs_info:*' enable git
export RPROMPT="\$vcs_info_msg_0_ %(?.%F{green}√.%F{red}?%?"

# cpair $(get_recovery_warning)$(account_info)%{$fg_bold[green]%}%m:%{$reset_color%}%{$fg_bold[blue]%}%~%{$reset_color%}%{$fg_bold[green]%}$(git_prompt_info)%{$reset_color%}%{$fg[cyan]%}$(k8s_context)%{$reset_color%}%{$fg_bold[red]%}%(?..(rc=%?%) )%{$reset_color%}%#%{$fg_bold[gray]%}$(job_info)%{$reset_color%}