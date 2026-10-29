{
	pkgs,
	...
}:
{
	programs.neovim.plugins = [
		{
			plugin = pkgs.vimPlugins.smear-cursor-nvim;
			type = "lua";
			config = /* lua */ ''
				-- disable some features in tty
				local is_tty = vim.fn.expand '$TERM' == "linux"

				require("smear_cursor").setup({
					cursor_color = "#66ff77",
					legacy_computing_symbols_support = not is_tty,
					stiffness = 0.5,
					damping = 1,
					trailing_stiffness = 0.475,
					never_draw_over_target = false,
					stiffness_insert_mode = 0.3,
					distance_stop_animating_vertical_bar = 0.1,
					trailing_stiffness_insert_mode = 0.25,
					matrix_pixel_threshold = 0.5,
					time_interval = 4;
				})
			'';
		}
	];
}
# vim:ts=2:
