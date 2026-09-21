# packages.nix

{ pkgs }: with pkgs; [

# База
gitFull
wget
gcc
gnumake
unzip
python3

# cli/tui утилиты
fastfetch
vim-full

# wm
xwayland-satellite
]

# vim:sw=2:ft=nix:
