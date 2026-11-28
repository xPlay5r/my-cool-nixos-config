{
	imports = [
		# cheatsheets
		./which-key.nix
		./cursor-smear.nix

		# appearance
		./lualine.nix
		./theme.nix

		# editing
		./mini-ai.nix
		./mini-surround.nix

		# lsp
		./coc
	];

	# base config
	# programs.neovim.plugins = with pkgs.vimPlugins; [
	# ];
}
# vim:ts=2:
