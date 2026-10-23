{
	pkgs,
	...
}:
{
	programs.neovim = {
		enable = true;
		defaultEditor = true;
		coc.enable = true;
		# https://cocnvim.com/docs/language-servers
		coc.settings = {
			# languageserver = {
			# 	bash = {
			# 		command = bash-language-server;
			# 		args = [ start ];
			# 		filetypes = [ sh ];
			# 	};
			# };
		};
		withNodeJs = true;
		# withPython3 = true;
		# withRuby = true;

		initLua = /* lua */ ''
			require("config.options")
			require("config.autocommands")
			require("config.mappings")
		'';
	};

	xdg.configFile."nvim/lua" = {
		recursive = true;
		source = ./lua;
	};

	# декларировать плагины и их настройки
	# https://gitlab.com/LongerHV/nixos-configuration/-/blob/master/modules/home-manager/myHome/neovim/default.nix?ref_type=heads
	programs.neovim.plugins = with pkgs.vimPlugins; [
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
		{
			plugin = pkgs.vimPlugins.blink-cmp;
			type = "lua";
			config = ''
				require("blink.cmp").setup()
			'';
		}
		# Snippet engine
		# https://github.com/L3MON4D3/LuaSnip
		{
			plugin = pkgs.vimPlugins.luasnip;
			type = "lua";
			config = '''';
		}
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
