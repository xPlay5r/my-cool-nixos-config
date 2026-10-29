{
	imports = [
		./kitty_scrollback_nvim.nix
		# ./colors.nix
	];

	programs.kitty = {
		enable = true;
		enableGitIntegration = true;

		# autoThemeFiles = {
		# 	dark = "TokyoNight";
		# 	light = "Gruvbox";
		# 	noPreference = "TokyoNight";
		# };

		themeFile = "tokyo_night_night";

		font.name = "JetBrainsMono Nerd Font";
		font.size = 11;

		settings = {
			editor = "nvim";
			shell = "bash --login";
			shell_integration = true;

			enable_audio_bell = true;

			cursor_shape = "beam";
			cursor_blink_interval = "0.5 ease-in-out";
			cursor_stop_blinking_after = 0;
			# cursor_trail = 5;
			# cursor_trail_decay = "0.1 0.4";
			# cursor_trail_start_threshold = 15;

			dynamic_background_opacity = true;
			background_opacity = 0.7;

			cursor = "#66ff77";
		};

		shellIntegration.mode = null;

		keybindings = {
			"ctrl+c" = "copy_and_clear_or_interrupt";
			"ctrl+v" = "paste_from_clipboard";
			"kitty_mod+v" = "paste";
			"ctrl+shift+o" = "copy_last_command_output";
		};
	};
}
# vim:ts=2:
