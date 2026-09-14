# home.nix

# https://www.chrisportela.com/posts/home-manager-flake/

{ pkgs, lib, ... }: {
  home.username = "vlad";
  home.homeDirectory = lib.mkForce "/home/vlad/";    

  home.packages = with pkgs; [
# cli/tui утилиты
python3
translate-shell
neovim tree-sitter
  ];

  home.stateVersion = "24.11"; # Comment out for error with "latest" version
  programs.home-manager.enable = true;
}

# vim:shiftwidth=2:
