{
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
}

# vim:ts=2:
