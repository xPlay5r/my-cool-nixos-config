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

				-- https://github.com/sphamba/smear-cursor.nvim/blob/main/lua/smear_cursor/config.lua
				require("smear_cursor").setup({
					cursor_color = "#66ff77",
					legacy_computing_symbols_support = not is_tty,
					stiffness = 0.7,
					trailing_stiffness = 0.6,
					damping = 1,
					never_draw_over_target = false,
					stiffness_insert_mode = 0.3,
					distance_stop_animating_vertical_bar = (not is_tty) and 0.1 or 0.875,
					trailing_stiffness_insert_mode = 0.25,
					matrix_pixel_threshold = 0.5,
					time_interval = 4;

					particles_enabled = true,
					particle_max_num = 50,
					particles_per_second = 50,
					particle_max_lifetime = 1000,
					particle_gravity = 0,
					particle_random_velocity = 500,
					-- particles_over_text = true;
				})
			'';
		}
	];
}
# vim:ts=2:
