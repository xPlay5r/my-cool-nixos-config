# packages.nix

{ pkgs }: with pkgs; [

# База
gitFull
wget
gcc
gnumake

# cli/tui утилиты
fastfetch
vim-full

# для wm/greeters
# для gnome
gnome-tweaks
# для niri
nemo qutebrowser
kitty
]

# vim:sw=2:ft=nix:
