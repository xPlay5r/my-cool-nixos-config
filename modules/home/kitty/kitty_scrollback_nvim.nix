{
	pkgs,
	...
}:
{
	home.packages = with pkgs; [
		vimPlugins.kitty-scrollback-nvim
	];

	programs.kitty = {
		settings = {
			allow_remote_control = "socket-only";
			listen_on = "unix:/tmp/kitty";
		};

		actionAliases = {
			"scrollback_nvim" = "kitten '${pkgs.vimPlugins.kitty-scrollback-nvim}/python/kitty_scrollback_nvim.py'";
		};

		keybindings = {
			"kitty_mod+h" = "scrollback_nvim";
			"kitty_mod+g" = "scrollback_nvim --config ksb_builtin_last_cmd_output";
		};

		mouseBindings = {
			"ctrl+shift+right press" = "ungrabbed combine : mouse_select_command_output : kitty_scrollback_nvim --config ksb_builtin_last_visited_cmd_output";
		};
	};
}
# vim:ts=2:
