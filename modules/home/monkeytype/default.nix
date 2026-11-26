{
	pkgs,
	config,
	inputs,
	...
}: let
	ln = path:
		config.lib.file.mkOutOfStoreSymlink ("${config.home.homeDirectory}/nix/dotfiles/" + path);
in {
	xdg.configFile."typy".source = ln "typy";
	xdg.configFile."typy".recursive = true;

	home.packages = [
		inputs.typy.packages.${pkgs.system}.default
	];
}
# vim:ts=2:
