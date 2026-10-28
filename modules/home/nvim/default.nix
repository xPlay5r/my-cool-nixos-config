{
	pkgs,
	...
}:
{
	imports = [
		./modules
	];

	programs.neovim = {
		enable = true;
		defaultEditor = true;
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
