{
	config,
	...
}:
{
	xdg.configFile."niri" = {
		source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nix/modules/home/niri/config";
		recursive = true;
	};
}
# vim:ts=2:
