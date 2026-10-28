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
		./indent-line.nix
		./theme.nix

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
