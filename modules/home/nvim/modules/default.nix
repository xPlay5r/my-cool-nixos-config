{
	imports = [
		# cheatsheets
		./which-key.nix
		./cursor-smear.nix
		./neoscroll.nix

		# appearance
		./lualine.nix
		./indent-line.nix
		./theme.nix

		# editing
		./mini-ai.nix
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
