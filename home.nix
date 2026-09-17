# home.nix

# https://www.chrisportela.com/posts/home-manager-flake/
# home-configuration.nix(5)
# https://learngitbranching.js.org/

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

  gtk.enable = true;
  gtk.colorScheme = "dark";

  home.pointerCursor.enable = true;
  home.pointerCursor.gtk.enable = true;
  home.pointerCursor.x11.enable = true;
  home.pointerCursor.package = pkgs.bibata-cursors;
  home.pointerCursor.name = "Bibata-Modern-Classic";
  home.pointerCursor.size = 32;
  gtk.cursorTheme.package = pkgs.bibata-cursors;
  gtk.cursorTheme.name = "Bibata-Modern-Classic";
  gtk.cursorTheme.size = 32;

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
ddgr

# для wm
gnome-tweaks
wl-clipboard brightnessctl
anyrun

# gui
nemo
kitty
gimp inkscape
  ];

  home.stateVersion = "24.11"; # Comment out for error with "latest" version
  programs.home-manager.enable = true;
}

# vim:shiftwidth=2:
