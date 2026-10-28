{
	pkgs,
	...
}:
{
	programs.neovim.plugins = with pkgs.vimPlugins; [
		{
			plugin = pkgs.vimPlugins.mini-indentscope;
			type = "lua";
			config = /* lua */ ''
				-- disable some features in tty
				local is_tty = vim.fn.expand '$TERM' == "linux"
				local indent_char = is_tty and "▌" or "▎"

				require("mini.indentscope").setup({
					draw = {
						animation = require('mini.indentscope').gen_animation.quadratic({
							easing = 'out', duration = 200, unit = 'total'
						})
					},
					symbol = indent_char
				})

				vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", { fg = "#1010e0" })

				-- vim.api.
			'';
		}
		{
			plugin = pkgs.vimPlugins.indent-blankline-nvim;
			type = "lua";
			config = /* lua */ ''
				-- disable some features in tty
				local is_tty = vim.fn.expand '$TERM' == "linux"
				local indent_char = is_tty and "▌" or "▎"
				require("ibl").setup({
					scope = {
						highlight = "MyAccentColor",
						show_start = false,
						show_end = false
					},
					indent = { char = indent_char }
				})
			'';
		}
	];
}
# vim:ts=2:
