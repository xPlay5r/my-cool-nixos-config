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
	services.mpd.enable = true;
	services.mpd.musicDirectory = /home/vlad/Music;
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
	gtk.theme.package = pkgs.catppuccin-gtk;
	gtk.theme.name = "catppuccin-frappe-blue-standard";
	gtk.gtk4.theme.package = pkgs.catppuccin-gtk;
	gtk.gtk4.theme.name = "catppuccin-frappe-blue-standard";

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
		"${pkgs.anyrun}/lib/libshell.so"
		"${pkgs.anyrun}/lib/libniri_focus.so"
	];
	programs.anyrun.extraConfigFiles."applications.run".text = ''
		Config(
			prefix: "!",
			hide_description: false,
			// The terminal used for running terminal based desktop entries, if left as `None` a static list of terminals is used
			// to determine what terminal to use.
			terminal: Some(Terminal(
				// The main terminal command
				command: "kitty",
				// What arguments should be passed to the terminal process to run the command correctly
				// {} is replaced with the command in the desktop entry
				args: "-o confirm_os_window_close=-1 -e {}",
			)),
		)
	'';
	programs.anyrun.extraConfigFiles."symbols.ron".text = ''
		Config(
			prefix: "",
			symbols: {
				// "name": "text to be copied"
				"shrug": "¯\\_(ツ)_/¯",
				"=>": "⇒",
				"!=>": "⇏",
			},
			max_entries: 3,
		)
	'';
	programs.anyrun.extraConfigFiles."dictionary.ron".text = ''
		Config(
			prefix: "?",
		)
	'';
	programs.anyrun.extraConfigFiles."websearch.ron".text = ''
		Config(
			prefix: "/",
			engines: [Google]
		)
	'';

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

	nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
		"steam" "steam-unwrapped"
	];

	home.packages = with pkgs; [
# gui
kitty
steam
# mindustry
telegram-desktop
bristol
prismlauncher
hyperspeedcube
obs-studio
brave
gimp
inkscape
nemo nemo-fileroller nemo-preview
libreoffice
pavucontrol
nwg-look # для проверки темы
dconf-editor

# для wm
gnome-tweaks
wl-clipboard brightnessctl
anyrun playerctl

# cli/tui утилиты
python3
translate-shell
neovim tree-sitter
ddgr
lsd bat htop btop
jq
	];

	home.stateVersion = "24.11"; # Comment out for error with "latest" version
	programs.home-manager.enable = true;
}

# vim:ts=2:
