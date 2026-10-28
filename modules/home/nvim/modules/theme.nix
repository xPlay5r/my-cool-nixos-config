{
	pkgs,
	...
}:
{
	programs.neovim.plugins = with pkgs.vimPlugins; [
		nvim-web-devicons
		{
			plugin = pkgs.vimPlugins.tokyonight-nvim;
			type = "lua";
			config = ''
				-- disable some features in tty
				local is_tty = vim.fn.expand '$TERM' == "linux"

				if not is_tty then
					vim.api.nvim_set_hl(0, "StatusLine", { bg="NONE" })
					vim.api.nvim_set_hl(0, "StatusLineNC", { bg="NONE" })
					require("tokyonight").setup({
						style = "night",
						transparent = true,
						on_highlights = function(hl, c)
							vim.o.cursorline = false
						end
					})
					vim.cmd.colorscheme("tokyonight")
				end
			'';
		}
	];
}
# vim:ts=2:
