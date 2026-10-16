{
	programs.neovim = {
		enable = true;
		defaultEditor = true;
		withNodeJs = true;
		# withPython3 = true;
		# withRuby = true;

		initLua = let
			# https://noogle.dev/f/builtins/readFile/
			readFile = file: builtins.readFile file;
			# https://noogle.dev/f/builtins/concatStringsSep/
			addCfgs = builtins.concatStringsSep "\n"; # still function
		in
			addCfgs [
				(readFile ./autocommands.lua)
				(readFile ./options.lua)
				(readFile ./mappings.lua)
			];
			# ''
			# 	set number
			# '';
	};

	# .lua files need changes
}

# vim:ts=2:
