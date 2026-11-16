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

	xdg.configFile."niri".source =	./config;
}
# vim:ts=2:
