# home.nix

# https://www.chrisportela.com/posts/home-manager-flake/

{ pkgs, lib, ... }: {
  home.username = "vlad";
  home.homeDirectory = lib.mkForce "/home/vlad/";    

  # wm
  services.network-manager-applet.enable = true;
  services.blueman-applet.enable = true;

  programs.waybar.enable = true;
  services.playerctld.enable = true;
  services.awww.enable = true;
  services.swaync.enable = true;

  programs.anyrun.enable = true;

  home.packages = with pkgs; [
# cli/tui утилиты
python3
translate-shell
neovim tree-sitter

# для wm
wl-clipboard brightnessctl
  ];

  home.stateVersion = "24.11"; # Comment out for error with "latest" version
  programs.home-manager.enable = true;
}

# vim:shiftwidth=2:
