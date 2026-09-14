# packages.nix

{ pkgs }: with pkgs; [

# База
gitFull
wget
gcc
gnumake

# cli/tui утилиты
python3
translate-shell
fastfetch
vim-full
neovim tree-sitter

# для wm/greeters
# для gnome
gnome-tweaks
# для niri
waybar awww swaynotificationcenter networkmanagerapplet
blueman wofi swaylock playerctl brightnessctl anyrun
nemo qutebrowser
kitty
]

# vim:sw=2:ft=nix:
