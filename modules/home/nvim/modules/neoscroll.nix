{
	pkgs,
	...
}:
{
	programs.neovim.plugins = [
		pkgs.vimPlugins.neoscroll-nvim
	];
}
# vim:ts=2:
