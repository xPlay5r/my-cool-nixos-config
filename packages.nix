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
wofi swaylock playerctl brightnessctl anyrun
nemo qutebrowser
kitty
]

# vim:sw=2:ft=nix:
