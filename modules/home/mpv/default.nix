{
	pkgs,
	...
}:
{
	home.packages = with pkgs; [
		mpv
	];
}

# vim:ts=2:
