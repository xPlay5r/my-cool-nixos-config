# Все сразу -- настройки gtk, dconf, pointerCursor
# Мне лень разделять на файлы это,
# к тому же у меня это очень близко в голове лежит
{
	pkgs,
	...
}:
{
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
}
# vim:ts=2:
