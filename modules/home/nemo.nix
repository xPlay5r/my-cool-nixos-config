{
	pkgs,
	...
}:
{
	home.packages = with pkgs; [
		nemo-with-extensions
	];

	dconf.settings."org/nemo/preferences" = {
		show-hidden-files = true;
	};
}
# vim:ts=2:
