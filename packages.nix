# packages.nix

{ pkgs }: with pkgs; [

# База
gitFull
wget
gcc

# cli/tui утилиты
translate-shell
fastfetch
vim-full
neovim tree-sitter

# для wm/greeters
gnome gnome-tweaks

]

# vim:ft=nix:
