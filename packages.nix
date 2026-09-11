# packages.nix

{ pkgs }: with pkgs; [

# База
gitFull
wget
gcc
g++

# cli/tui утилиты
translate-shell
fastfetch
vim-full
neovim tree-sitter

]

# vim:ft=nix:
