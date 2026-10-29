{
	pkgs,
	...
}:
{
	programs.neovim.plugins = [
		{
			plugin = pkgs.vimPlugins.which-key-nvim;
			type = "lua";
			config = /* lua */ ''
				require("which-key").setup({
					win = {
						no_overlap = false,
						width = 80,
						-- height = { min = 4, max = 25 },
						col = math.huge,
						row = math.huge,
						border = "rounded",
						padding = { 0, 1 },
						title_pos = "left",
						wo = {
							-- winblend = 10
						},
					},
					layout = {
						width = { max = 40 }, -- min and max width of the columns
						spacing = 2, -- spacing between columns
					}
				})
			'';
		}
	];
}
# vim:ts=2:
