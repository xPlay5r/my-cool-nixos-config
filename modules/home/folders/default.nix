{
	config,
	...
}:
{
	xdg.enable = true;
	xdg.userDirs = {
		enable = true;
		createDirectories = true;

		desktop = "${config.home.homeDirectory}/Desktop";
		documents = "${config.home.homeDirectory}/Documents";
		download = "${config.home.homeDirectory}/Downloads";
		music = "${config.home.homeDirectory}/Music";
		pictures = "${config.home.homeDirectory}/Pictures";
		projects = "${config.home.homeDirectory}/smth";
		publicShare = "${config.home.homeDirectory}/Public";
		templates = "${config.home.homeDirectory}/Templates";
		videos = "${config.home.homeDirectory}/Videos";

		# extraConfig = {
		# };
	};
}
# vim:ts=2:
