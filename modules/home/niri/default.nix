{
	imports = [
		./awww.nix
		./anyrun.nix
		./swaync.nix
		./swaylock+swayidle.nix
		./nemo.nix
		./waybar-tray-applets.nix
		./gtk-dconf-cursor-settings.nix
		./imv.nix
		./mpv.nix
	];

	xdg.configFile."niri/config.kdl".source =	./config/config.kdl;
	xdg.configFile."niri/focuse_throne.sh".source = ./config/focuse_throne.sh;
	xdg.configFile."niri/wallpaper".source = ./config/wallpaper;
}
# vim:ts=2:
