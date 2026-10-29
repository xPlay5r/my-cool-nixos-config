{
	pkgs,
	...
}:
{
	imports = [
		# cheatsheets
		# ./
		# key cheatsheet or sum TODO

		# appearance
		./lualine.nix
		./indent-line.nix
		./theme.nix

		# editing
		./mini-surround.nix

		# lsp
		./cpp.nix
		./nix.nix
		./lua.nix
	];

	# base config
	# programs.neovim.plugins = with pkgs.vimPlugins; [
	# ];
}
# vim:ts=2:
