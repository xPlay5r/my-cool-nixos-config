{
	config,
	...
}:
{
	programs.neovim = {
		enable = true;
		defaultEditor = true;
		withNodeJs = true;
		# withPython3 = true;

		initLua = /* lua */ ''
			require("config.options")
			require("config.autocommands")
			require("config.mappings")
		'';
	};

	home.file.".config/nvim/lua" = {
		source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nix/modules/home/nvim/lua";
		recursive = true;
	};
}

# vim:ts=2:
