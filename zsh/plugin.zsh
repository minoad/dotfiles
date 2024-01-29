#!/usr/bin/env bash
# zplug
source ~/.zplug/init.zsh

# Make sure to use double quotes
#zplug "zsh-users/zsh-history"
zplug "zsh-users/zsh-history-substring-search"
zplug "MichaelAquilina/zsh-you-should-use"
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"
zplug "wting/autojump"
zplug "agkozak/z"
zplug "fdellwing/zsh-bat"
zplug "zsh-users/zsh-syntax-highlighting"
zplug "jeffreytse/zsh-vi-mode"
zplug "agkozak/zsh-z"

# Use the package as a command
# And accept glob patterns (e.g., brace, wildcard, ...)
zplug "Jxck/dotfiles", as:command, use:"bin/{histuniq,color}"

zplug 'zplug/zplug', hook-build:'zplug --self-manage'
zplug "plugins/git", from:oh-my-zsh
zplug "b4b4r07/enhancd", use:init.sh

#zplug "plugins/autojump", from:oh-my-zsh
zplug "plugins/copybuffer", from:oh-my-zsh
zplug "plugins/copyfile", from:oh-my-zsh
zplug "plugins/copypath", from:oh-my-zsh
zplug "plugins/dirhistory", from:oh-my-zsh
zplug "plugins/docker", from:oh-my-zsh
zplug "plugins/git", from:oh-my-zsh
zplug "plugins/jsontools", from:oh-my-zsh
zplug "plugins/kubectl", from:oh-my-zsh
zplug "plugins/sudo", from:oh-my-zsh
zplug "plugins/web-search", from:oh-my-zsh

# zplug "plugins/vscode", from:oh-my-zsh
zplug load --verbose

if ! zplug check --verbose; then
    printf "Install zplug plugins? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi
