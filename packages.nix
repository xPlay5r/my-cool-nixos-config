# packages.nix

{ pkgs }: with pkgs; [

# База
gitFull
wget
gcc
gnumake

# cli/tui утилиты
translate-shell
fastfetch
vim-full
neovim tree-sitter

# для wm/greeters
# для gnome
gnome-tweaks
# для niri
waybar awww swaynotificationcenter networkmanagerapplet
blueman wofi swaylock playerctl anyrun
nemo qutebrowser
kitty
]

# vim:sw=2:ft=nix:
