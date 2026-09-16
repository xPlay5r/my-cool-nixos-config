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
  programs.anyrun.config.plugins = [
    "${pkgs.anyrun}/lib/libapplications.so"
    "${pkgs.anyrun}/lib/libsymbols.so"
    "${pkgs.anyrun}/lib/libwebsearch.so"
    "${pkgs.anyrun}/lib/libdictionary.so"
    "${pkgs.anyrun}/lib/libtranslate.so"
  ];

  programs.qutebrowser.enable = true;
  programs.qutebrowser.settings = {
    # colors.webpage.darkmode.enabled = true;
    colors.webpage.preferred_color_scheme = "dark";
    content.blocking.method = "both";
    scrolling.smooth = true;
    spellcheck.languages = [ "en-US" "ru-RU" ];
    tabs.position = "left";
    tabs.select_on_remove = "last-used";
    colors.tabs.bar.bg = "#111";
  };

  home.packages = with pkgs; [
# cli/tui утилиты
python3
translate-shell
neovim tree-sitter

# для wm
gnome-tweaks
wl-clipboard brightnessctl
anyrun

# gui
nemo
kitty
  ];

  home.stateVersion = "24.11"; # Comment out for error with "latest" version
  programs.home-manager.enable = true;
}

# vim:shiftwidth=2:
