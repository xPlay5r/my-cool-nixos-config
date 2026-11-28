{
	config,
	...
}: let
	ln = path:
		config.lib.file.mkOutOfStoreSymlink ("${config.home.homeDirectory}/nix/dotfiles/" + path);
in {
	xdg.configFile."niri" = {
		source = ln "niri";
		recursive = true;
	};
}
# vim:ts=2:
