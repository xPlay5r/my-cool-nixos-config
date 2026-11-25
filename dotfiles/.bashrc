#! /usr/bin/env bash

# .bashrc

# https://www.gnu.org/software/bash/manual/bash.html

export EDITOR=nvim
export MANPAGER='nvim +Man!'

alias h=history
alias ls='lsd --color auto --hyperlink auto -A'
alias l='lsd --color auto --hyperlink auto -A -l'
alias lt='lsd --color auto --hyperlink auto -A --tree'
alias li='lsd --color auto --hyperlink auto -A -i'
alias e='nvim'
alias c='nvim    +"exe \"norm 1\\<C-o>\""'
alias cc='nvim   +"exe \"norm 2\\<C-o>\""'
alias ccc='nvim  +"exe \"norm 3\\<C-o>\""'
alias cccc='nvim +"exe \"norm 4\\<C-o>\""'
alias reb='sudo nixos-rebuild switch'
alias ZQ=logout
alias q=logout

function mkcd {
	mkdir "$1" && cd "$1"
}

function mkcdp {
	mkdir -p "$1" && cd "$1"
}
