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

  gtk.iconTheme.package = pkgs.papirus-icon-theme;
  gtk.iconTheme.name = "Papirus-Dark";
  gtk.theme.package = pkgs.orchis-theme;
  gtk.theme.name = "Orchis-Dark";

  # dconf-editor
  # dconf watch /
  dconf.settings."org/gnome/desktop/interface" = {
    cursor-theme = "Bibata-Modern-Classic";
    cursor-size = 32;
    color-scheme = "prefer-dark";
    accent-color = "blue";

    clock-format = "24h";
    clock-show-seconds = true;
    enable-hot-corners = false;
  };

  dconf.settings."org/nemo/preferences" = {
    show-hidden-files = true;
  };

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
# gui
brave
gimp
inkscape
kitty
nemo nemo-fileroller nemo-preview
pavucontrol
nwg-look # для проверки темы
dconf-editor

# для wm
gnome-tweaks
wl-clipboard brightnessctl
anyrun

# cli/tui утилиты
python3
translate-shell
neovim tree-sitter
ddgr
lsd bat
jq
  ];

  home.stateVersion = "24.11"; # Comment out for error with "latest" version
  programs.home-manager.enable = true;
}

# vim:shiftwidth=2:
