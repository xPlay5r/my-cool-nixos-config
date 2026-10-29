{
	pkgs,
	...
}:
{
	programs.neovim.plugins = [
		{
			plugin = pkgs.vimPlugins.lualine-nvim;
			type = "lua";
			config = ''
				-- disable some features in tty
				local is_tty = vim.fn.expand '$TERM' == "linux"

				if not is_tty then
					require('lualine').setup {
						options = {
							theme = 'tokyonight'
						}
					}
				end
			'';
		}
	];
}
# vim:ts=2:
