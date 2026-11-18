{
	pkgs,
	...
}:
{
	home.packages = with pkgs; [ anyrun ];

	programs.anyrun.enable = true;
	programs.anyrun.config.plugins = [
		"${pkgs.anyrun}/lib/libapplications.so"
		"${pkgs.anyrun}/lib/libsymbols.so"
		"${pkgs.anyrun}/lib/libwebsearch.so"
		"${pkgs.anyrun}/lib/libdictionary.so"
		"${pkgs.anyrun}/lib/libtranslate.so"
		"${pkgs.anyrun}/lib/libshell.so"
		"${pkgs.anyrun}/lib/libniri_focus.so"
	];

	programs.anyrun.extraConfigFiles."applications.run".text = ''
		Config(
			prefix: "",
			hide_description: false,
			// The terminal used for running terminal based desktop entries, if left as `None` a static list of terminals is used
			// to determine what terminal to use.
			terminal: Some(Terminal(
				// The main terminal command
				command: "kitty",
				// What arguments should be passed to the terminal process to run the command correctly
				// {} is replaced with the command in the desktop entry
				args: "-o confirm_os_window_close=-1 -e {}",
			)),
		)
	'';

	programs.anyrun.extraConfigFiles."symbols.ron".text = ''
		Config(
			prefix: "",
			symbols: {
				// "name": "text to be copied"
				"shrug": "¯\\_(ツ)_/¯",
				"=>": "⇒",
				"!=>": "⇏",
			},
			max_entries: 3,
		)
	'';

	programs.anyrun.extraConfigFiles."dictionary.ron".text = ''
		Config(
			prefix: "?",
		)
	'';

	programs.anyrun.extraConfigFiles."websearch.ron".text = ''
		Config(
			prefix: "/",
			engines: [Google]
		)
	'';
}

# vim:ts=2:
